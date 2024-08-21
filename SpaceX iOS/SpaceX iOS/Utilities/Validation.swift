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
        let emailRegEx = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+))\\]"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
