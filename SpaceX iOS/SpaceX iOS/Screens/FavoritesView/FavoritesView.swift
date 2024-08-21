//
//  FavoritesView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var viewModel: RocketListViewModel
    @State private var selectedRocket: Rocket? = nil
    @State private var isTapAnimating = false
    
    init(viewModel: RocketListViewModel) {
        self.viewModel = viewModel
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("SpaceXBackGround")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 850)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
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
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.top, 60)
            }
            
            .navigationTitle("SpaceX Rockets")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarModifier(
                backgroundColor: .clear,
                foregroundColor: .white,
                font: UIFont(name: "Muli", size: 20)!,
                withSeparator: false
            )
            .onAppear {
                viewModel.fetchFavoriteRocketsFromRealm()
            }
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
