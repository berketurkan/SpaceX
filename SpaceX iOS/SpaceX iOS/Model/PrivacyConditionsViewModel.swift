//
//  PrivacyConditionsViewModel.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

final class PrivacyConditionsViewModel: ObservableObject {
    @Published var membershipAgreement: String = ""
    @Published var privacyPolicy: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadConditions() {
        isLoading = true
        NetworkManager.shared.fetchMembershipAgreement { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let agreement):
                    self?.membershipAgreement = agreement
                case .failure(let error):
                    self?.errorMessage = "Failed to load Membership Agreement: \(error.localizedDescription)"
                }
            }
        }
        
        NetworkManager.shared.fetchPrivacyPolicy { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let policy):
                    self?.privacyPolicy = policy
                case .failure(let error):
                    self?.errorMessage = "Failed to load Privacy Policy: \(error.localizedDescription)"
                }
                self?.isLoading = false
            }
        }
    }
}

