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
    var systemIconName: String? = nil
    var bundleImageName: String? = nil
    var isEnabled: Bool = true
    var disabledColor: Color = .gray
    var enabledColor: Color = Color("lightGreen")
    var font: Font = .headline 
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            HStack {
                if let systemIconName = systemIconName {
                    Image(systemName: systemIconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                else if let bundleImageName = bundleImageName {
                    Image(bundleImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                Text(title)
                    .font(font)
                    .foregroundColor(textColor)
                    .padding(.leading, (systemIconName != nil || bundleImageName != nil) ? 3 : 0)
            }
            .frame(width: width, height: height)
            .padding()
            .background(isEnabled ? enabledColor : disabledColor)
            .cornerRadius(30)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .disabled(!isEnabled)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(
            title: "Log in",
            width: 200,
            height: 40,
            systemIconName: "apple.logo",
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
