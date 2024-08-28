//
//  ForgotPasswordViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 28.08.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailSent: Bool = false
    @Published var errorMessage: String? = nil

    func sendPasswordResetEmail(completion: @escaping (Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self.isEmailSent = true
                    // Set a flag in Firestore that a reset has been requested
                    let db = Firestore.firestore()
                    db.collection("users").document(self.email).setData(["resetRequested": true], merge: true)
                    completion(true)
                }
            }
        }
    }
    
    func checkIfEmailExists(completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else if let signInMethods = signInMethods, !signInMethods.isEmpty {
                    // Email exists
                    completion(true)
                } else {
                    // Email does not exist
                    self.errorMessage = "This email is not associated with any account."
                    completion(false)
                }
            }
        }
    }

}
