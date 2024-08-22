//
//  LoginView.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("loginBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("spaceXLogo")
                        .padding(.top, 180)
                        .padding(.bottom, 50)
                    
                    CustomTextField(
                        text: $email,
                        placeholder: "E-mail",
                        isSecure: false,
                        imageName: "iconEmail",
                        secureImage: "",
                        backgroundColor: Color.white.opacity(0.1),
                        iconColorWhenEmpty: .white,
                        iconColorWhenFilled: Color("lightGreen"),
                        onCommit: {
                            
                        }
                    )
                    .padding(.bottom, 20)
                    
                    CustomTextField(
                        text: $password,
                        placeholder: "Password",
                        isSecure: true,
                        imageName: "iconPassword",
                        secureImage: "iconHidePassword",
                        backgroundColor: Color.white.opacity(0.1),
                        iconColorWhenEmpty: .white,
                        iconColorWhenFilled: Color("lightGreen"),
                        onCommit: {
                            
                        }
                    )
                    
                    CustomButton(
                        title: "Forgot Password",
                        textColor: .white,
                        width: 120,
                        height: 20,
                        iconName: "",
                        isEnabled: true,
                        disabledColor: .clear,
                        enabledColor: .clear,
                        font: .footnote,
                        action: {
                        }
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    
                    CustomButton(
                        title: "Log in",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        iconName: "",
                        isEnabled: !(email.isEmpty || password.isEmpty),
                        disabledColor: Color.white.opacity(0.1),
                        enabledColor: Color("lightGreen"),
                        font: .headline,
                        action: {
                        }
                    )
                    .padding(.top, 35)
                    
                    Text("or")
                        .foregroundColor(.white)
                    
                    CustomButton(
                        title: "Sign in with Apple",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        iconName: "apple.logo",
                        isEnabled: true,
                        disabledColor: Color.white.opacity(0.1),
                        enabledColor: Color.white.opacity(0.1),
                        font: .headline,
                        action: {
                        }
                    )
                    .padding(.top, 10)
                    
                    CustomButton(
                        title: "Sign up",
                        textColor: .white,
                        width: 48,
                        height: 17,
                        iconName: "",
                        isEnabled: true,
                        disabledColor: .clear,
                        enabledColor: .clear,
                        font: .footnote,
                        action: {
                            // Sign up action
                        }
                    )
                    .padding(.top, 25)
                    
                    Spacer()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
