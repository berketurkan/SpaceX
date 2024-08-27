//
//  PrivacyandConditonsView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct PrivacyandConditonsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: SignUpViewModel
    @State var isAccepted1: Bool = false
    @State var isAccepted2: Bool = false
    @State var navigateToStep3: Bool = false
    @StateObject private var ConditonViewModel = PrivacyConditionsViewModel()
    @State var cancel: Bool = false
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("signUpStep2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .padding(.horizontal, 30)
                
                ConditionCell(
                    title: "Membership Agreement",
                    description: ConditonViewModel.membershipAgreement
                )
                .padding(.top, 20)
                
                ConditionCell(
                    title: "Privacy Policy",
                    description: ConditonViewModel.privacyPolicy
                )
                .padding(.top, 15)
                
                AcceptRow(isAccepted: $isAccepted1, text: "I have read and accept to Membership Contract.")
                
                AcceptRow(isAccepted: $isAccepted2, text: "I have read and accept to Privacy Policy.")
                
                CustomButton(
                    title: "Continue",
                    textColor: .white,
                    width: 240,
                    height: 30,
                    isEnabled: isAccepted1 && isAccepted2,
                    disabledColor: Color.gray.opacity(0.5),
                    enabledColor: Color("lightGreen"),
                    font: .headline,
                    action: {
                        navigateToStep3 = true
                    }
                )
                .padding(.top, 20)
                
                Spacer()
                
            }
            .padding(.top, 50)
        }
        .onAppear {
            ConditonViewModel.loadConditions()
        }
        .navigationDestination(isPresented: $navigateToStep3) {
            ActivationView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $cancel) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Privacy and Conditions")
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

//struct SignUpStep2View_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpStep2View()
//    }
//}
