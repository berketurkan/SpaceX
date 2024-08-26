//
//  SignUpStep4Fail.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct SignUpStep4Fail: View {
    @Environment(\.presentationMode) private var presentationMode

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
                
                Image("IconFail")
                    .resizable()
                    .frame(width: 145, height: 80)
                    .padding(.top, 80)
                
                Text("Activation failed.")
                    .font(.custom("Muli", size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 13)
                
                Text("The activation link is invalid or has been used before.")
                    .font(.custom("Muli", size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 1)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                
                CustomButton(
                    title: "Send new activation link",
                    textColor: Color("lightGreen"),
                    width: 210,
                    height: 28,
                    isEnabled: true,
                    disabledColor: .gray.opacity(0.5),
                    enabledColor: .gray.opacity(0.5),
                    font: Font.custom("Muli", size: 14).bold(),
                    action: {
                        
                        print("Send Again tapped")
                    }
                )
                .padding(.top, 260)
                
                Spacer()
                
            }
            .padding(.top, 50)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Activation Failed")
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

struct SignUpStep4Fail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep4Fail()
    }
}
