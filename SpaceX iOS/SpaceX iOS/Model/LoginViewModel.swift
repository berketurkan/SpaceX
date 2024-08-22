//
//  LoginViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 22.08.2024.
//

import Foundation
import FirebaseAuth

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
    
    func signIn() async -> Bool {
        hasError = false
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            isLoggedIn = true
            return true
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            isLoggedIn = false
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
    
    func fetchFavoriteRockets() {
    }
    
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
