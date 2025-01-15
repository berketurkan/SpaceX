//
//  NavigationBarModifier.swift
//  SpaceX iOS
//
//  Created by Vestel on 19.08.2024.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor
    var foregroundColor: UIColor
    var font: UIFont
    var withSeparator: Bool
    
    func configureNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor, .font: font]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor, .font: font]
        if !withSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func body(content: Content) -> some View {
        configureNavigationBar()
        return content
    }
}

extension View {
    func navigationBarModifier(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .label, font: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold), withSeparator: Bool = true) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, font: font, withSeparator: withSeparator))
    }
}
