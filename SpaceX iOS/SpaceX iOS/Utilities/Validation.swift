//
//  Validation.swift
//  SpaceX iOS
//
//  Created by Vestel on 21.08.2024.
//

import SwiftUI

struct PasswordValidator {
    let password: String
    
    var isUppercaseMet: Bool {
        password.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    var isLowercaseMet: Bool {
        password.rangeOfCharacter(from: .lowercaseLetters) != nil
    }
    
    var isNumberMet: Bool {
        password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var isSpecialCharacterMet: Bool {
        password.rangeOfCharacter(from: .symbols) != nil || password.rangeOfCharacter(from: .punctuationCharacters) != nil
    }
    
    var isLengthMet: Bool {
        password.count >= 8
    }
    
    var isValid: Bool {
        isUppercaseMet && isLowercaseMet && isNumberMet && isSpecialCharacterMet && isLengthMet
    }
}

struct EmailValidator {
    let email: String
    
    var isValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
