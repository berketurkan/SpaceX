//
//  CustomButton.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var textColor: Color = .white
    var width: CGFloat = 50
    var height: CGFloat = 50
    var iconName: String = ""
    var isEnabled: Bool = true
    var disabledColor: Color = .gray
    var enabledColor: Color = Color("lightGreen")
    var font: Font = .headline // Default font
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            HStack {
                if !iconName.isEmpty {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                
                Text(title)
                    .font(font)
                    .foregroundColor(textColor)
                    .padding(.leading, iconName.isEmpty ? 0 : 3)
            }
            .frame(width: width, height: height)
            .padding()
            .background(isEnabled ? enabledColor : disabledColor)
            .cornerRadius(10)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(
            title: "Log in",
            width: 200,
            height: 40,
            iconName: "apple.logo",
            isEnabled: true,
            disabledColor: Color.gray,
            enabledColor: Color.green,
            font: Font.custom("Muli", size: 20),
            action: {
                print("Log in tapped")
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
