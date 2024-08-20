//
//  RemoteImage.swift
//  SpaceX iOS
//
//  Created by Vestel on 18.08.2024.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    func load(fromURLString urlString: String) {
        let correctedURLString = correctImgurURLIfNeeded(urlString: urlString)
        
        NetworkManager.shared.downloadImage(fromURLString: correctedURLString) { uiImage in
            DispatchQueue.main.async {
                if let uiImage = uiImage {
                    self.image = Image(uiImage: uiImage)
                } else {
                    print("[ERROR] Failed to load image from URL: \(correctedURLString)")
                    self.image = Image("TestFalcon")
                }
            }
        }
    }
    
    private func correctImgurURLIfNeeded(urlString: String) -> String {
        if urlString.starts(with: "https://imgur.com/") {
            return urlString.replacingOccurrences(of: "https://imgur.com/", with: "https://i.imgur.com/")
        } else {
            return urlString
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("TestFalcon").resizable()
        
    }
}

struct RocketRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURLString: urlString) }
        
    }
}
