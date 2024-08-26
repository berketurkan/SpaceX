//
//  SignUpStep2View.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct SignUpStep2View: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var isAccepted1: Bool = false
    @State var isAccepted2: Bool = false
    
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
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultricies massa molestie laoreet sed vitae risus."
                )
                .padding(.top, 20)
                
                ConditionCell(
                    title: "Privacy Policy",
                    description: """
                        1. Lorem ipsum dolor sit amet
                        Consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus. Consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultrices massa molestie laoreet sed vitae risus.
                        """
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
                        print("Continue button pressed")
                    }
                )
                .padding(.top, 20)
                
                Spacer()
                
            }
            .padding(.top, 50)
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

struct SignUpStep2View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep2View()
    }
}
