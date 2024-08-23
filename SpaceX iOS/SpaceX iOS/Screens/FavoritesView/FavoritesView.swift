//
//  FavoritesView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI
import LocalAuthentication

struct FavoritesView: View {
    
    @ObservedObject var viewModel: RocketListViewModel
    @State private var selectedRocket: Rocket? = nil
    @State private var isDetailPresented = false
    @State private var isTapAnimating = false
    @State private var isAuthenticated = false
    @State private var authenticationFailed = false
    
    init(viewModel: RocketListViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: authenticationFailed ? 1 : 0)
            
            VStack {
                if isAuthenticated {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach($viewModel.favoriteRockets, id: \.id) { $rocket in
                                RocketListCell(
                                    rocket: $rocket,
                                    isTapAnimating: selectedRocket?.id == rocket.id && isTapAnimating,
                                    viewModel: viewModel
                                )
                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    selectedRocket = rocket
                                    withAnimation {
                                        isTapAnimating = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            isTapAnimating = false
                                            isDetailPresented = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                else {
                    Text("Authentication required to view favorites.")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 40)
                }
            }
            .padding(.top, 60)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("SpaceX Rockets")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarModifier(
            backgroundColor: .clear,
            foregroundColor: .white,
            font: UIFont(name: "Muli", size: 20)!,
            withSeparator: false
        )
        .navigationDestination(isPresented: $isDetailPresented) {
            
            if let selectedRocket = selectedRocket {
                RocketDetailView(rocket: $viewModel.rockets[viewModel.rockets.firstIndex(where: { $0.id == selectedRocket.id })!], viewModel: viewModel)
            }
            
        }
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to view your favorites."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                        authenticationFailed = false
                        viewModel.fetchFavoriteRockets()
                        viewModel.syncFavoriteStatus()
                    } else {
                        isAuthenticated = false
                        authenticationFailed = true
                    }
                }
            }
        } else {
            isAuthenticated = false
            authenticationFailed = true
        }
    }
}
