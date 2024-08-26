//
//  Network Manager.swift
//  SpaceX iOS
//
//  Created by Vestel on 18.08.2024.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://api.spacexdata.com/v4/"
    private let rocketsURL = baseURL + "rockets"
    private let upcomingLaunchesURL = "https://api.spacexdata.com/v5/launches/upcoming"
    
    private let membershipAgreementURL = "https://firebasestorage.googleapis.com/v0/b/spacex-690e8.appspot.com/o/MembershipAgreement.txt?alt=media&token=c1983868-6100-45cd-94ec-308492bc84b8"
    private let privacyPolicyURL = "https://firebasestorage.googleapis.com/v0/b/spacex-690e8.appspot.com/o/PrivacyConditions.txt?alt=media&token=28994437-6ef3-40e4-a4b7-25d48a3863b3"
    
    
    private init() {}
    
    func getRockets(completed: @escaping (Result<[Rocket], APError>) -> Void) {
        guard let url = URL(string: rocketsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error  {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Rocket].self, from: data)
                completed(.success(decodedResponse))
            }   catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context.debugDescription)")
                print("Context: \(context)")
                completed(.failure(.invalidData))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription)")
                print("Coding Path: \(context.codingPath)")
                completed(.failure(.invalidData))
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
                print("Coding Path: \(context.codingPath)")
                completed(.failure(.invalidData))
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch: \(context.debugDescription)")
                print("Coding Path: \(context.codingPath)")
                completed(.failure(.invalidData))
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage (fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
        
    }
    
    func getUpcomingLaunches(completed: @escaping (Result<[Launch], APError>) -> Void) {
        guard let url = URL(string: upcomingLaunchesURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error  {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Launch].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("Error decoding launch data: \(error.localizedDescription)")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func fetchTextData(from urlString: String, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data, let textData = String(data: data, encoding: .utf8) else {
                completed(.failure(.invalidData))
                return
            }
            
            completed(.success(textData))
        }
        
        task.resume()
    }
    
    func fetchMembershipAgreement(completed: @escaping (Result<String, APError>) -> Void) {
        fetchTextData(from: membershipAgreementURL, completed: completed)
    }
    
    func fetchPrivacyPolicy(completed: @escaping (Result<String, APError>) -> Void) {
        fetchTextData(from: privacyPolicyURL, completed: completed)
    }
    
}
