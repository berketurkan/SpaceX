//
//  CustomTextField.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    var imageName: String
    var secureImage: String
    var backgroundColor: Color = Color.white
    var iconColorWhenEmpty: Color = .white
    var iconColorWhenFilled: Color = Color("lightGreen")
    var onCommit: (() -> Void)?
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white)
                    .padding(.leading, 43)
                    .font(Font.custom("Muli", size: 20))
                    .bold()
            }
            
            HStack {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(text.isEmpty ? iconColorWhenEmpty : iconColorWhenFilled)
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                
                if isSecure && !isPasswordVisible {
                    SecureField("", text: $text, onCommit: {
                        onCommit?()
                    })
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                } else {
                    TextField("", text: $text, onCommit: {
                        onCommit?()
                    })
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                }
                
                if isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(secureImage)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isPasswordVisible && !text.isEmpty ? Color("lightGreen") : .white)
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
        .frame(height: 25)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor)
        )
        .padding(.horizontal, 25)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        CustomTextField(
            text: $text,
            placeholder: "Email",
            isSecure: true,
            imageName: "iconPassword",
            secureImage: "iconHidePassword",
            backgroundColor: .gray
        )
    }
}
