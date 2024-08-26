//
//  ForgotPasswordView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
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
                    //padding(.top, 0)
                
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
                    text: $email,
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
                        // Handle commit action
                    }
                )
                .padding(.leading, 0)
                
                Spacer()  // Spacer to push the button down
                
                HStack {
                    Spacer()
                    CustomButton(
                        title: "Continue",
                        textColor: .white,
                        width: 240,
                        height: 30,
                        isEnabled: !email.isEmpty,
                        disabledColor: Color.white.opacity(0.1),
                        enabledColor: Color("lightGreen"),
                        font: .headline,
                        action: {
                            
                        }
                    )
                    Spacer()
                }
                .padding(.bottom, 100)
            }
            .padding(.top, 70)
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


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
