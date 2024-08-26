//
//  PasswordConditionsView.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct PasswordConditionsView: View {
    let passwordValidator: PasswordValidator

    var body: some View {
        VStack(alignment: .leading) {
            // First HStack
            HStack(alignment: .top, spacing: 10) {
                Text("Password must contain:")
                    .font(.custom("Muli", size: 12))
                    .foregroundColor(.white.opacity(0.7))
                
                passwordConditionView(isMet: passwordValidator.isUppercaseMet, text: "Uppercase letters")
                passwordConditionView(isMet: passwordValidator.isLowercaseMet, text: "Lowercase letters")
            }
            .padding(.leading, 30)
            .padding(.top, 10)
            
            HStack(spacing: 20) {
                passwordConditionView(isMet: passwordValidator.isNumberMet, text: "Numbers")
                passwordConditionView(isMet: passwordValidator.isSpecialCharacterMet, text: "Special characters")
                passwordConditionView(isMet: passwordValidator.isLengthMet, text: "8 character minimum")
            }
            .padding(.leading, 30)
            .padding(.top, 0)
            
        }
    }
}

private func passwordConditionView(isMet: Bool, text: String) -> some View {
    HStack {
        Image(systemName: "circle.fill" )
            .foregroundColor(isMet ? Color("lightGreen") : .white.opacity(0.9))
            .font(.system(size: 6))
        Text(text)
            .font(.custom("Muli", size: 10))
            .foregroundColor(isMet ? Color("lightGreen") : .white.opacity(0.9))
    }
}

//struct PasswordConditionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordConditionsView()
//    }
//}
