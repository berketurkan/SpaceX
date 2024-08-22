//
//  RocketListViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 18.08.2024.
//

import SwiftUI
import RealmSwift
import FirebaseFirestore
import FirebaseAuth

final class RocketListViewModel: ObservableObject {
    
    @Published var rockets: [Rocket] = []
    @Published var favoriteRockets: [Rocket] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    private var userID: String?
    
    private let realm = try! Realm()
    private let database = Firestore.firestore()
    
    init() {
        fetchCurrentUserID()
    }
    
    func fetchCurrentUserID() {
        if let user = Auth.auth().currentUser {
            self.userID = user.uid
        }
    }
    
    func fetchRocketsAndFavorites() {
        guard let userID = userID else { return }
        
        let dispatchGroup = DispatchGroup()
        
        // Fetch rockets
        dispatchGroup.enter()
        NetworkManager.shared.getRockets { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rocketsData):
                    self.rockets = rocketsData
                case .failure(let error):
                    print("[ERROR] Failed to fetch rockets data: \(error)")
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        print("[ERROR] Invalid response from server")
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        print("[ERROR] Invalid URL")
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        print("[ERROR] Invalid data received")
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                        print("[ERROR] Unable to complete request")
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        database.collection("users").document(userID).collection("favRockets").getDocuments { snapshot, error in
            if let error = error {
                print("[ERROR] Error fetching favorite rockets from Firestore: \(error.localizedDescription)")
            } else {
                var favorites: [Rocket] = []
                if let documents = snapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        if let rocketID = data["id"] as? String {
                            for rocket in self.rockets {
                                if rocket.id == rocketID {
                                    favorites.append(rocket)
                                    break
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.favoriteRockets = favorites
                }
            }
            dispatchGroup.leave()
        }
        
        // Sync favorite status after both fetches complete
        dispatchGroup.notify(queue: .main) {
            self.syncFavoriteStatus()
        }
    }
    
    func toggleFavorite(for rocket: Rocket) {
        for i in 0..<rockets.count {
            if rockets[i].id == rocket.id {
                rockets[i].toggleFavorite()
                if rockets[i].isFavorite {
                    saveFavoriteRealm(for: rockets[i])
                    saveFavoriteRocketToFirestore(rocket, userID: userID ?? "")
                } else {
                    removeFavoriteRealm(for: rockets[i])
                    removeFavoriteRocketFromFirestore(rocket, userID: userID ?? "")
                    removeRocketFromFavorites(rocket)
                }
                break
            }
        }
    }
    
    func fetchFavoriteRockets() {
        guard let userID = userID else { return }
        
        database.collection("users").document(userID).collection("favRockets").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching favorite rockets from Firestore: \(error)")
                return
            }
            
            var favorites: [Rocket] = []
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                    
                    if let rocketID = data["id"] as? String {
                        for rocket in self.rockets {
                            if rocket.id == rocketID {
                                favorites.append(rocket)
                                break
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.favoriteRockets = favorites
            }
        }
    }
    
    func fetchFavoriteRocketsFromRealm() {
        let favoriteRocketObjects = realm.objects(FavoriteRocket.self)
        var favorites: [Rocket] = []
        
        for favoriteRocket in favoriteRocketObjects {
            for rocket in rockets {
                if favoriteRocket.id == rocket.id {
                    favorites.append(rocket)
                    break
                }
            }
        }
        DispatchQueue.main.async {
            self.favoriteRockets = favorites
        }
    }
    
    func syncFavoriteStatus() {
        
        fetchFavoriteRockets()
        
        for favorite in favoriteRockets {
            for i in 0..<rockets.count {
                if rockets[i].id == favorite.id {
                    rockets[i].isFavorite = true
                    break
                }
            }
        }
    }
    
    private func saveFavoriteRocketToFirestore(_ rocket: Rocket, userID: String) {
        let favoriteData: [String: Any] = [
            "id": rocket.id,
            "name": rocket.name
        ]
        
        database.collection("users").document(userID).collection("favRockets").document(rocket.id).setData(favoriteData) { error in
            if let error = error {
                print("Error saving rocket to Firestore: \(error)")
            } else {
                print("Rocket saved successfully to Firestore")
            }
        }
    }
    
    private func removeFavoriteRocketFromFirestore(_ rocket: Rocket, userID: String) {
        database.collection("users").document(userID).collection("favRockets").document(rocket.id).delete { error in
            if let error = error {
                print("Error removing rocket from Firestore: \(error)")
            } else {
                print("Rocket removed successfully from Firestore")
            }
        }
    }
    
    private func saveFavoriteRealm(for rocket: Rocket) {
        let favoriteRocket = FavoriteRocket()
        favoriteRocket.id = rocket.id
        
        do {
            try realm.write {
                if realm.object(ofType: FavoriteRocket.self, forPrimaryKey: rocket.id) == nil {
                    realm.add(favoriteRocket)
                }
            }
        } catch {
            print("Error adding favorite rocket ID: \(error)")
        }
    }
    
    private func removeRocketFromFavorites(_ rocket: Rocket) {
        for i in 0..<favoriteRockets.count {
            if favoriteRockets[i].id == rocket.id {
                favoriteRockets.remove(at: i)
                break
            }
        }
    }
    
    private func removeFavoriteRealm(for rocket: Rocket) {
        if let favorite = realm.object(ofType: FavoriteRocket.self, forPrimaryKey: rocket.id) {
            do {
                try realm.write {
                    realm.delete(favorite)
                }
            } catch {
                print("Error removing favorite rocket ID: \(error)")
            }
        }
    }
    
    func getRockets() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("[DEBUG] getRockets() called")
        isLoading = true
        
        NetworkManager.shared.getRockets { result in
            DispatchQueue.main.async {
                self.isLoading = false
                print("[DEBUG] Finished fetching rockets, processing result...")
                
                switch result {
                case .success(let rocketsData):
                    print("[DEBUG] Success: Rockets data fetched successfully")
                    self.rockets = rocketsData
                    //self.syncFavoriteStatus()
                    print("[DEBUG] Total rockets parsed: \(self.rockets.count)")
                    self.rockets.forEach { rocket in
                        //print("[DEBUG] Rocket ID: \(rocket.id)")
                        //print("[DEBUG] Name: \(rocket.name)")
                        //print("[DEBUG] Description: \(rocket.description)")
                        //print("[DEBUG] Image URL: \(rocket.imageURL)")
                        //print("[DEBUG] Flickr Images: \(rocket.flickr_images.joined(separator: ", "))")
                        //print("[DEBUG] Height: \(rocket.height.meters) meters / \(rocket.height.feet) feet")
                        //print("[DEBUG] Diameter: \(rocket.diameter.meters) meters / \(rocket.diameter.feet) feet")
                        //print("[DEBUG] Mass: \(rocket.mass.kg) kg / \(rocket.mass.lb) lb")
                        //print("[DEBUG] Payload Weights: \(rocket.payload_weights.map { "\($0.name): \($0.kg) kg / \($0.lb) lb" }.joined(separator: ", "))")
                        //print("[DEBUG] ----------")
                    }
                    
                case .failure(let error):
                    print("[ERROR] Failed to fetch rockets data: \(error)")
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        print("[ERROR] Invalid response from server")
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        print("[ERROR] Invalid URL")
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        print("[ERROR] Invalid data received")
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                        print("[ERROR] Unable to complete request")
                    }
                }
            }
        }
    }
}
