//
//  UpcomingView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct UpcomingView: View {
    let mockLaunches = Launch.mockDataLaunches
    @StateObject private var viewModel = LaunchViewModel()
    @State private var selectedLaunch: Launch? = nil
    @State private var isDetailPresented = false
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        ForEach(viewModel.launches.indices, id: \.self) { index in
                            LaunchListCell(
                                launch: viewModel.launches[index],
                                index: index,
                                onExploreTapped: {
                                    selectedLaunch = viewModel.launches[index]
                                    isDetailPresented = true
                                }
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 0)
                }
            }
            .padding(.top, 80)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Upcoming Launchers")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchUpcomingLaunches()
        }
        .navigationDestination(isPresented: $isDetailPresented) {
            if let selectedLaunch = selectedLaunch {
                if let launchIndex = viewModel.launches.firstIndex(where: { launch in launch.id == selectedLaunch.id }) {
                    LaunchDetailView(
                        launch: selectedLaunch,
                        backgroundImageName: "upcoming\(launchIndex % 3 + 1)",
                        index: launchIndex
                    )
                }
            }
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}

