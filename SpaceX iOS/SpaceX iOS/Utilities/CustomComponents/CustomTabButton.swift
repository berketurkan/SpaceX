//
//  CustomTabButton.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct CustomTabButton: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let selectedColor: Color
    let unselectedColor: Color
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            VStack(spacing: 0.1) {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isSelected ? selectedColor : unselectedColor)
                    .scaledToFill()
                    .frame(width: 55, height: 28)
                Text(title)
                    .foregroundColor(isSelected ? .white : .white.opacity(0.6))
                    .font(Font.custom("Muli", size: 12))
            }
        }
        
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabButton(imageName: "FavButton",
                        title: "Favorite",
                        isSelected: true,
                        selectedColor: .red,
                        unselectedColor: .gray,
                        action: {}
        )
    }
}
