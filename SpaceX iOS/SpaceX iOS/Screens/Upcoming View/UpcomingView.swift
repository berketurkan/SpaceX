//
//  UpcomingView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct UpcomingView: View {
    // Using mock data launches for the demonstration
    let mockLaunches = Launch.mockDataLaunches
        
    
    var body: some View {
        ZStack {
            // Background image
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        ForEach(mockLaunches.indices, id: \.self) { index in
                            LaunchListCell(
                                launch: mockLaunches[index],
                                index: index
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
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}

