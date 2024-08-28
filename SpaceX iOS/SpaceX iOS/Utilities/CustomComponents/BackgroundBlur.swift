//
//  BackgroundBlur.swift
//  SpaceX iOS
//
//  Created by Vestel on 28.08.2024.
//

import SwiftUI

struct BackgroundBlur: ViewModifier {
    var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .blur(radius: isPresented ? 10 : 0)
            .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}
