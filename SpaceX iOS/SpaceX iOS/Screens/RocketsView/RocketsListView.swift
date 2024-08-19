//
//  RocketsListView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct RocketsListView: View {
    @State private var selectedRocket: Rocket? = nil
    @State private var isTapAnimating = false
    @State private var isDetailPresented = false
    let rockets = MockData.sampleRockets
    
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
                            ForEach(rockets, id: \.id) { rocket in
                                RocketListCell(
                                    rocket: rocket,
                                    isTapAnimating: selectedRocket?.id == rocket.id && isTapAnimating
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
            }
            .navigationTitle("SpaceX Rockets")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isDetailPresented) {
                if let rocket = selectedRocket {
                    RocketDetailView(rocket: rocket)
                }
            }
        }
    }
}


struct RocketsListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketsListView()
    }
}
