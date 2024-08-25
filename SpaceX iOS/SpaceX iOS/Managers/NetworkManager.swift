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
}
