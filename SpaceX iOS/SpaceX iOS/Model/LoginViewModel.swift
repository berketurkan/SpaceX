//
//  LoginViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 22.08.2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import UIKit
import FirebaseFirestore

struct User {
    let uid: String
    let email: String
}

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published private var _currentUser: User? = nil
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    var currentUser: User {
        return _currentUser ?? User(uid: "", email: "")
    }
    
    init() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?._currentUser = User(uid: user.uid, email: user.email ?? "")
                self?.isLoggedIn = true
            } else {
                self?._currentUser = nil
                self?.isLoggedIn = false
            }
        }
    }
    
    
    func signInWithGoogle(completion: @escaping (Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootViewController!) { [weak self] result, error in
            guard error == nil else {
                self?.hasError = true
                self?.errorMessage = error?.localizedDescription ?? "Unknown error"
                completion(false)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self?.hasError = true
                self?.errorMessage = "Missing user or token"
                completion(false)
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                    self?.hasError = true
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                    return
                }
                
                self?.createUserDocumentIfNeeded()
                self?.isLoggedIn = true
                completion(true)
            }
        }
    }
    
    func createUserDocumentIfNeeded() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let database = Firestore.firestore()
        let userDocument = database.collection("users").document(userID)
        
        userDocument.getDocument { document, error in
            if let document = document, document.exists {
                print("User document already exists.")
            } else {
                let userData: [String: Any] = [
                    "email": Auth.auth().currentUser?.email ?? "",
                ]
                
                userDocument.setData(userData) { error in
                    if let error = error {
                        print("Error creating user document: \(error.localizedDescription)")
                    } else {
                        print("User document successfully created in Firestore.")
                    }
                }
            }
        }
    }
    
    func isEmailVerified() -> Bool {
        return Auth.auth().currentUser?.isEmailVerified ?? false
    }
    
    func signIn() async -> Bool {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async {
                if result.user.isEmailVerified {
                    self.hasError = false
                    self.isLoggedIn = true
                } else {
                    self.hasError = true
                    self.errorMessage = "E-mail verification is needed. Please check your inbox."
                }
            }
            return result.user.isEmailVerified
        } catch let error as NSError {
            DispatchQueue.main.async {
                self.hasError = true
                switch error.code {
                case AuthErrorCode.userNotFound.rawValue,
                    AuthErrorCode.wrongPassword.rawValue,
                    AuthErrorCode.internalError.rawValue:
                    self.errorMessage = "Your password or e-mail address is wrong."
                case AuthErrorCode.networkError.rawValue:
                    self.errorMessage = "Network error. Please try again later."
                default:
                    self.errorMessage = "Your password or e-mail address is wrong."
                }
            }
            return false
        }
    }
    
    func signOut() {
        hasError = false
        do {
            try Auth.auth().signOut()
            self._currentUser = nil
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            self.hasError = true
            self.errorMessage = signOutError.localizedDescription
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
