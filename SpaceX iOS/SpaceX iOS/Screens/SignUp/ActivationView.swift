//
//  SignUpStep3View.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct SignUpStep3View: View {
    @Environment(\.presentationMode) private var presentationMode

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
                       
                        print("Send Again tapped")
                    }
                )
                .padding(.top, 0)
                
                Spacer()
                
            }
            .padding(.top, 50)
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
                    width: 40,
                    height: 20,
                    isEnabled: true,
                    disabledColor: .clear,
                    enabledColor: .clear,
                    font: .headline,
                    action: {
                        
                    }
                )
            }
        }
    }
}

struct SignUpStep3View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep3View()
    }
}
