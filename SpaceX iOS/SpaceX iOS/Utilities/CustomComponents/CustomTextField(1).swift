//
//  CustomTextField.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var label: String?
    var showLabel: Bool = false 
    var placeholder: String
    var isSecure: Bool = false
    var imageName: String
    var secureImage: String
    var backgroundColor: Color = Color.white
    var iconColorWhenEmpty: Color = .white
    var iconColorWhenFilled: Color = Color("lightGreen")
    var placeHolderTextColor: Color = .white
    var fontSize: CGFloat = 20
    var height: CGFloat = 25
    var width: CGFloat = 300
    var onCommit: (() -> Void)?
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if showLabel, let labelText = label {
                Text(labelText)
                    .font(.custom("Muli", size: 13))
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
            }
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(placeHolderTextColor)
                        .padding(.leading, 43)
                        .font(Font.custom("Muli", size: fontSize))
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
                        .autocapitalization(.none)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        
                    } else {
                        TextField("", text: $text, onCommit: {
                            onCommit?()
                        })
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
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
            .frame(width: width, height: height)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
            )
            .padding(.horizontal, 25)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        CustomTextField(
            text: $text,
            label: "New Password",
            showLabel: true,  
            placeholder: "Enter your new password",
            isSecure: true,
            imageName: "iconPassword",
            secureImage: "iconHidePassword",
            backgroundColor: .gray
        )
    }
}
