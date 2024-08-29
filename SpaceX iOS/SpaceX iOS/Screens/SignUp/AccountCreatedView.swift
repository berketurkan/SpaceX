//
//  AccountCreatedView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct AccountCreatedView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var isLoggedIn: Bool
    @State var showMain: Bool = false
    @State var cancel: Bool = false

    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("signUpStep4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .padding(.horizontal, 30)
                
                Image("SuccesIcon")
                    .resizable()
                    .frame(width: 145, height: 80)
                    .padding(.top, 80)
                
                Text("Your account has been created.")
                    .font(.custom("Muli", size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 13)
                
                Text("Your account information has been sent to your e-mail address.")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 1)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                
                CustomButton(
                    title: "Continue",
                    textColor: .white,
                    width: 210,
                    height: 30,
                    isEnabled: true,
                    disabledColor: Color("lightGreen"),
                    enabledColor: Color("lightGreen"),
                    font: Font.custom("Muli", size: 14).bold(),
                    action: {
                        //isLoggedIn = true
                        showMain = true
                    }
                )
                .padding(.top, 270)
                
                Spacer()
                
            }
            .padding(.top, 50)
        }
        .navigationDestination(isPresented: $showMain) {
            LoginView()
        }
        .navigationDestination(isPresented: $cancel) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Account Created")
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
                    height: 30,
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

//struct SignUpStep4Success_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpStep4Success()
//    }
//}
