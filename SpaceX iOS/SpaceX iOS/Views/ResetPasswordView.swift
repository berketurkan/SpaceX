//
//  ResetPasswordView.swift
//  SpaceX iOS
//
//  Created by Vestel on 23.08.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    
    private var passwordValidator: PasswordValidator {
        PasswordValidator(password: newPassword)
    }
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                Text("Reset Password")
                    .font(.custom("Muli", size: 28))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.leading, 30)
                    .padding(.bottom, 5)
                
                
                Text("Your password must be different from previous used passwords.")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 30)
                
                CustomTextField(
                    text: $currentPassword,
                    placeholder: "Enter your current password",
                    isSecure: true,
                    imageName: "iconPassword",
                    secureImage: "iconHidePassword",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {
                        
                    }
                )
                .padding(.top, 20)
                
                HStack(alignment: .top, spacing: 10) {
                    Text("Password must contain:")
                        .font(.custom("Muli", size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    
                    passwordConditionView(isMet: passwordValidator.isUppercaseMet, text: "Uppercase letters")
                    passwordConditionView(isMet: passwordValidator.isLowercaseMet, text: "Lowercase letters")
                }
                .padding(.leading, 30)
                .padding(.top, 10)
                
                HStack(spacing: 20) {
                    passwordConditionView(isMet: passwordValidator.isNumberMet, text: "Numbers")
                    passwordConditionView(isMet: passwordValidator.isSpecialCharacterMet, text: "Special characters")
                    passwordConditionView(isMet: passwordValidator.isLengthMet, text: "8 character minimum")
                }
                .padding(.leading, 30)
                .padding(.top, 0)
                
                Text("New Password")
                    .font(.custom("Muli", size: 13))
                    .foregroundColor( .white.opacity(0.9))
                    .padding(.top, 5)
                    .padding(.leading, 30)

                
                CustomTextField(
                    text: $newPassword,
                    placeholder: "Enter your new password",
                    isSecure: true,
                    imageName: "iconPassword",
                    secureImage: "iconHidePassword",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {
    
                    }
                )
                .padding(.top, 0)
                
                Spacer()
                
                CustomButton(
                    title: "Continue",
                    width: 200,
                    height: 30,
                    isEnabled: passwordValidator.isValid,
                    disabledColor: Color.gray.opacity(0.5),
                    enabledColor: Color("lightGreen"),
                    font: Font.custom("Muli", size: 20).bold(),
                    action: {
                        // Handle password reset action
                        print("Password reset initiated.")
                    }
                )
                .padding(.bottom, 60)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .padding(.top, 100)
        }
    }
    
    private func passwordConditionView(isMet: Bool, text: String) -> some View {
        HStack {
            Image(systemName: "circle.fill" )
                .foregroundColor(isMet ? Color("lightGreen") : .white.opacity(0.9))
                .font(.system(size: 6))
            Text(text)
                .font(.custom("Muli", size: 10))
                .foregroundColor(isMet ? Color("lightGreen") : .white.opacity(0.9))
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
