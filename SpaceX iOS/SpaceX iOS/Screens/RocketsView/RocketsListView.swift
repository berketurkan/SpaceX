//
//  RocketsListView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct RocketsListView: View {
    //    @StateObject var viewModel = RocketListViewModel()
    @ObservedObject var viewModel: RocketListViewModel
    @State private var selectedRocket: Rocket? = nil
    @State private var isTapAnimating = false
    @State private var isDetailPresented = false
    @Binding var isLoggedIn: Bool
    let rockets = MockData.sampleRockets
    
    init(viewModel: RocketListViewModel, isLoggedIn: Binding<Bool>) {
        self.viewModel = viewModel
        self._isLoggedIn = isLoggedIn
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
            
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach($viewModel.rockets, id: \.id) { $rocket in
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
            .padding(.top, 60)
        }.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isLoggedIn = false
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
            }
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
            if viewModel.rockets.isEmpty {
                viewModel.fetchRocketsAndFavorites()
            }
        }
    }
}


//struct RocketsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RocketsListView()
//    }
//}
