//
//  SpaceXTabView.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct SpaceXTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            if selectedTab == 0 {
                RocketsListView()
            } else if selectedTab == 1 {
                FavoritesView()
            } else if selectedTab == 2 {
                UpcomingView()
            }
            
            Spacer()
            
            HStack {
                CustomTabButton(
                    imageName: "SpaceXRocketsButton",
                    title: "Rockets",
                    isSelected: selectedTab == 0,
                    selectedColor: Color("lightGreen"),
                    unselectedColor: .white.opacity(0.7),
                    action: {
                        selectedTab = 0
                    }
                )
                Spacer()
                
                CustomTabButton(
                    imageName: "FavButton",
                    title: "Favorites",
                    isSelected: selectedTab == 1,
                    selectedColor: Color("lightGreen"),
                    unselectedColor: .white,
                    action: {
                        selectedTab = 1
                    }
                )
                
                Spacer()
                CustomTabButton(
                    imageName: "SpaceXUpcomingButton",
                    title: "Upcoming",
                    isSelected: selectedTab == 2,
                    selectedColor: Color("lightGreen"),
                    unselectedColor: .white.opacity(0.9),
                    action: {
                        selectedTab = 2
                    }
                )
            }
           
            .padding()
            .frame(height: 55)
            .background(Color(.gray).opacity(0.9))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.6), lineWidth: 1))
            .padding(.horizontal, 22)
            .padding(.top, 732)
            .padding(.bottom, 30)
            
        }
        
    }
}

struct SpaceXTabView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceXTabView()
    }
}
