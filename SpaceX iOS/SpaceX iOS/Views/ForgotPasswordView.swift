//
//  ForgotPasswordView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @State private var isShowingPopup: Bool = false
    @State private var isShowingLogin: Bool = false
    @State private var popupMessage = "Processing..."
    @State private var pollingTimer: Timer?
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Forgot your password?")
                    .font(.custom("Muli", size: 28))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.leading, 24)
                    .padding(.bottom, 2)
                
                Text("No worries!\nEnter your e-mail address below and we will send you the instructions to create a new one. ")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.leading, 3)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 22)
                
                Text("E-mail")
                    .font(.custom("Muli", size: 13))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.leading, 30)
                
                CustomTextField(
                    text: $viewModel.email,
                    placeholder: "Enter your e-mail address",
                    isSecure: false,
                    imageName: "iconEmail",
                    secureImage: "",
                    backgroundColor: Color.white.opacity(0.1),
                    iconColorWhenEmpty: .white,
                    iconColorWhenFilled: Color("lightGreen"),
                    fontSize: 13,
                    height: 18,
                    width: 335,
                    onCommit: {
                        
                    }
                )
                .padding(.leading, 0)
                
                Spacer()
                
                HStack {
                    Spacer()
                    CustomButton(
                        title: "Continue",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        isEnabled:  EmailValidator(email: viewModel.email).isValid,
                        disabledColor: Color.white.opacity(0.1),
                        enabledColor: Color("lightGreen"),
                        font: .headline,
                        action: {
                            viewModel.sendPasswordResetEmail { success in
                                if success {
                                    isShowingPopup = true
                                } else {
                                    popupMessage = viewModel.errorMessage ?? "Unknown error occurred."
                                    isShowingPopup = true
                                }
                            }
                        }
                    )
                    Spacer()
                }
                .padding(.bottom, 100)
            }
            .padding(.top, 70)
            
            if isShowingPopup {
                Color.clear
                    .background(BlurView(style: .systemMaterial))
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                    }
                
                CustomPopup(
                    width: 300,
                    height: 250,
                    imageWidth: 70,
                    imageHeight: 70,
                    backgroundColor: .gray.opacity(0.9),
                    title: "Check your e-mail address.",
                    description: "Click the button in the sent mail\nto set a new password.",
                    buttonText: "OK",
                    imageName: "activationEmailIcon",
                    onButtonTap: {
                        isShowingPopup = false // Dismiss the popup
                        isShowingLogin = true // Navigate to the login view
                    }
                )
            }
        }
        .navigationDestination(isPresented: $isShowingLogin) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
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
                    font: .headline,
                    action: {
                        isShowingLogin = true
                    }
                )
            }
        }
    }
     
    struct BlurView: UIViewRepresentable {
        var style: UIBlurEffect.Style
        
        func makeUIView(context: Context) -> UIVisualEffectView {
            let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
            return view
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = UIBlurEffect(style: style)
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
