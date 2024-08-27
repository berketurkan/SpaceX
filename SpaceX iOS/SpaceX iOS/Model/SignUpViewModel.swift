//
//  SignUpViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 27.08.2024.
//

import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phone: String = ""
    @Published var country: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isActivated: Bool = false
    
    func signUp(completion: @escaping (Bool) -> Void) {
        isLoading = true
        errorMessage = nil
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                } else if let user = authResult?.user {
                    user.sendEmailVerification { error in
                        if let error = error {
                            self?.errorMessage = error.localizedDescription
                            completion(false)
                        } else {
                            self?.isActivated = false // Initially false until verified
                            completion(true)
                        }
                    }
                } else {
                    self?.errorMessage = "User creation failed unexpectedly."
                    completion(false)
                }
            }
        }
    }
    
    func checkEmailVerification(completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.reload { error in
            if let user = Auth.auth().currentUser, user.isEmailVerified {
                self.isActivated = true
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func sendVerificationEmail(completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                print("Error sending verification email: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
