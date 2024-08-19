//
//  RocketsListView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct RocketsListView: View {
    let rockets = MockData.sampleRockets
    @State private var selectedRocket: Rocket?
    
    var body: some View {
        NavigationView {
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
                                RocketListCell(selectedRocket: $selectedRocket,rocket: rocket)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.top, 60)
            }
            .navigationTitle("SpaceX Rockets")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RocketsListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketsListView()
    }
}
