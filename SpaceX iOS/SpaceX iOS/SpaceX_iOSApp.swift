//
//  SpaceX_iOSApp.swift
//  SpaceX iOS
//
//  Created by Vestel on 12.08.2024.
//

import SwiftUI

@main
struct SpaceX_iOSApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Set title color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
