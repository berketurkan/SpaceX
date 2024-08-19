//
//  RocketListViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 18.08.2024.
//

import SwiftUI

final class RocketListViewModel: ObservableObject {
    
    @Published var rockets: [Rocket] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getRockets() {
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
                    print("[DEBUG] Total rockets parsed: \(self.rockets.count)")
                    //                case .success(let rocketsData):
                    //                    print("[DEBUG] Success: Rockets data fetched successfully")
                    //
                    //                    self.rockets = rocketsData.map { apiRocket in
                    //                        print("[DEBUG] Mapping API rocket data to Rocket model")
                    //
                    //                        return Rocket(
                    //                            id: apiRocket.id ?? "0",
                    //                            name: apiRocket.name,
                    //                            description: apiRocket.description,
                    //                            imageURL: apiRocket.flickr_images.first ?? "",
                    //                            height: Dimension(meters: apiRocket.height.meters ?? 0.0, feet: apiRocket.height.feet ?? 0.0),
                    //                            diameter: Dimension(meters: apiRocket.diameter.meters ?? 0.0, feet: apiRocket.diameter.feet ?? 0.0),
                    //                            mass: Mass(kg: apiRocket.mass.kg, lb: apiRocket.mass.lb),
                    //                            flickr_images: apiRocket.flickr_images,
                    //                            payload_weights: apiRocket.payload_weights.map { apiPayload in
                    //                                Payload(
                    //                                    id: apiPayload.id,
                    //                                    name: apiPayload.name,
                    //                                    kg: apiPayload.kg,
                    //                                    lb: apiPayload.lb
                    //                                )
                    //                            }
                    //                        )
                    //                    }
                    //
                    self.rockets.forEach { rocket in
                        print("[DEBUG] Rocket ID: \(rocket.id)")
                        print("[DEBUG] Name: \(rocket.name)")
                        print("[DEBUG] Description: \(rocket.description)")
                        //print("[DEBUG] Image URL: \(rocket.imageURL)")
                        print("[DEBUG] Height: \(rocket.height.meters) meters / \(rocket.height.feet) feet")
                        print("[DEBUG] Diameter: \(rocket.diameter.meters) meters / \(rocket.diameter.feet) feet")
                        print("[DEBUG] Mass: \(rocket.mass.kg) kg / \(rocket.mass.lb) lb")
                        print("[DEBUG] Payload Weights: \(rocket.payload_weights.map { "\($0.name): \($0.kg) kg / \($0.lb) lb" }.joined(separator: ", "))")
                        print("[DEBUG] Flickr Images: \(rocket.flickr_images.joined(separator: ", "))")
                        print("[DEBUG] ----------")
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
