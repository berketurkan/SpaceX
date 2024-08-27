//
//  SignUpMainView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct SignUpMainView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel = SignUpViewModel()
    @State private var navigateToConditions: Bool = false
    @State var cancel: Bool = false
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                Image("signUpStep1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .padding(.horizontal, 30)
                
                CustomTextField(
                    text: $viewModel.name,
                    label: "Name Surname",
                    showLabel: true,
                    placeholder: "Enter your name",
                    isSecure: false,
                    imageName: "nameIcon",
                    secureImage: "",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {}
                )
                .padding(.top, 20)
                .padding(.leading, 35)
                
                CustomTextField(
                    text: $viewModel.email,
                    label: "E-mail",
                    showLabel: true,
                    placeholder: "Enter your e-mail address",
                    isSecure: false,
                    imageName: "iconEmail",
                    secureImage: "",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {}
                )
                .padding(.leading, 35)
                
                CustomTextField(
                    text: $viewModel.password,
                    label: "Password",
                    showLabel: true,
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
                    onCommit: {}
                )
                .padding(.leading, 35)
                
                PasswordConditionsView(passwordValidator: PasswordValidator(password: viewModel.password))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
                
                CustomTextField(
                    text: $viewModel.phone,
                    label: "Phone",
                    showLabel: true,
                    placeholder: "Enter your phone number",
                    isSecure: false,
                    imageName: "phoneIcon",
                    secureImage: "",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {}
                )
                .padding(.top, 2)
                .padding(.leading, 35)
                
                CustomTextField(
                    text: $viewModel.country,
                    label: "Country",
                    showLabel: true,
                    placeholder: "Select your country",
                    isSecure: false,
                    imageName: "countryIcon",
                    secureImage: "",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    placeHolderTextColor: .white.opacity(0.6),
                    fontSize: 15,
                    height: 18,
                    width: 320,
                    onCommit: {}
                )
                .padding(.leading, 35)
                
                Spacer()
                CustomButton(
                    title: "Continue",
                    textColor: .white,
                    width: 240,
                    height: 30,
                    isEnabled: !viewModel.name.isEmpty &&
                        !viewModel.email.isEmpty &&
                        !viewModel.password.isEmpty &&
                        !viewModel.phone.isEmpty &&
                        !viewModel.country.isEmpty &&
                        EmailValidator(email: viewModel.email).isValid &&
                        PasswordValidator(password: viewModel.password).isValid,
                    disabledColor: Color.white.opacity(0.1),
                    enabledColor: Color("lightGreen"),
                    font: .headline,
                    action: {
                        navigateToConditions = true
                    }
                )
                .padding(.bottom, 100)
                
            }
            .padding(.top, 50)
        }
        .navigationDestination(isPresented: $navigateToConditions) {
            PrivacyandConditonsView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $cancel) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 14, height: 23)
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                CustomButton(
                    title: "Cancel",
                    textColor: .white.opacity(0.5),
                    width: 60,
                    height: 45,
                    isEnabled: true,
                    disabledColor: .clear,
                    enabledColor: .clear,
                    font: .subheadline,
                    action: {
                        cancel = true
                    }
                )
            }
        }
    }
}

//struct SignUpStep1View_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpStep1View()
//    }
//}
