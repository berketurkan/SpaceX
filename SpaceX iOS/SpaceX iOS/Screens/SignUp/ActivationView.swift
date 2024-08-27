//
//  ActivationView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct ActivationView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: SignUpViewModel
    @State private var showSuccessView = false
    @State private var showFailureView = false
    @State private var pollingTimer: Timer?
    @State var cancel: Bool = false
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("signUpStep3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .padding(.horizontal, 30)
                
                Image("activationEmailIcon")
                    .resizable()
                    .frame(width: 145, height: 80)
                    .padding(.top, 80)
                
                Text("Your activation e-mail has been sent.")
                    .font(.custom("Muli", size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 13)
                
                Text("To complete your registration, please click\nthe confirmation link.")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 1)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Text("Did not receive e-mail?")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 1)
                    .frame(width: 300, alignment: .center)
                    .padding(.top, 250)
                
                CustomButton(
                    title: "Send Again",
                    textColor: Color("lightGreen"),
                    width: 80,
                    height: 5,
                    isEnabled: true,
                    disabledColor: Color.clear,
                    enabledColor: Color.clear,
                    font: Font.custom("Muli", size: 14).bold(),
                    action: {
                        viewModel.sendVerificationEmail { success in
                            if success {
                                print("Verification email sent successfully.")
                            } else {
                                print("Failed to send verification email.")
                            }
                        }
                    }
                )
                .padding(.top, 0)
                
                Spacer()
                
            }
            .padding(.top, 50)
        }
        .navigationDestination(isPresented: $showSuccessView) {
            AccountCreatedView()
        }
        .navigationDestination(isPresented: $showFailureView) {
            ActivationFailedView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.signUp { success in
                if success {
                    startPollingForVerification()
                } else {
                    showFailureView = true
                }
            }
        }
        .onDisappear {
            stopPollingForVerification()
        }
        .navigationDestination(isPresented: $cancel) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Activation")
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
    
    private func startPollingForVerification() {
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            viewModel.checkEmailVerification { isVerified in
                if isVerified {
                    stopPollingForVerification()
                    showSuccessView = true
                }
            }
        }
    }
    
    private func stopPollingForVerification() {
        pollingTimer?.invalidate()
        pollingTimer = nil
    }
}

//struct SignUpStep3View_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpStep3View()
//    }
//}
