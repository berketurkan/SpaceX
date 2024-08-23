//
//  LoginView.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var isShowingMainView = false
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
                   SpaceXTabView(isLoggedIn: $isLoggedIn) 
        } else {
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
                        text: $viewModel.email,
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
                        text: $viewModel.password,
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
                    
                    if viewModel.hasError {
                        Text("Your password or e-mail address is wrong.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom("Muli", size: 10))
                            .foregroundColor(.red)
                            .padding(.top, 10)
                            .padding(.leading, 25)
                        
                    }
                    
                    CustomButton(
                        title: "Forgot Password",
                        textColor: .white,
                        width: 120,
                        height: 0,
                        isEnabled: true,
                        disabledColor: .clear,
                        enabledColor: .clear,
                        font: .footnote,
                        action: {
                        }
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 0)
                    
                    CustomButton(
                        title: "Log in",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        isEnabled: !(viewModel.email.isEmpty || viewModel.password.isEmpty),
                        disabledColor: Color.white.opacity(0.1),
                        enabledColor: Color("lightGreen"),
                        font: .headline,
                        action: {
                            //                            viewModel.signIn()
                            //                            if viewModel.isLoggedIn {
                            //                                isShowingMainView = true
                            //                            }
                            Task {
                                let success = await viewModel.signIn()
                                if success {
                                    isShowingMainView = true
                                    isLoggedIn = true
                                }
                            }
                        }
                    )
                    .padding(.top, 10)
                    
                    CustomButton(
                        title: "Sign In with Google",
                        textColor: .black,
                        width: 240,
                        height: 30,
                        bundleImageName: "GoogleIcon",
                        isEnabled: true,
                        disabledColor: Color.white,
                        enabledColor: Color.white,
                        font: .headline,
                        action: {
                            viewModel.signInWithGoogle { success in
                                if success {
                                    isShowingMainView = true
                                    isLoggedIn = true
                                } else {
                                   
                                }
                            }
                        }
                    )
                    .padding(.top, 10)
                    
                    CustomButton(
                        title: "Sign in with Apple",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        systemIconName: "apple.logo",
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
            .onAppear {
                viewModel.isLoggedIn = false
            }
            .navigationBarHidden(true)
        }
        
//        .navigationDestination(isPresented: $isShowingMainView) {
//            SpaceXTabView()
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
