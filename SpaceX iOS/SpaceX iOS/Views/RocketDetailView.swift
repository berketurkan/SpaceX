//
//  RocketDetailView.swift
//  SpaceX iOS
//
//  Created by Vestel on 15.08.2024.
//

import SwiftUI

struct RocketDetailView: View {
    
    @Binding var rocket: Rocket
    
    init(rocket: Binding<Rocket>) {
        self._rocket = rocket
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "lightGreen") ?? UIColor.white,
            .font: UIFont(name: "Nasalization", size: 20)!
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 450, height: 900)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 8)
            
            ScrollView {
                VStack {
                    HStack(spacing: 15) {
                        Image(rocket.imageURL)
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 250, height: 150)
                            .padding(.top, 120)
                            .padding(.trailing, 30)
                        
                        Button {
                            rocket.isFavorite.toggle()
                        } label: {
                            Image("FavButton")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(rocket.isFavorite ? Color("lightGreen") : .white)
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                        }
                    }
                    
                    Text(rocket.description)
                        .padding(.horizontal, 48)
                        .padding(.top, 25)
                        .foregroundColor(.white)
                        .font(Font.custom("Muli", size: 16))
                    
                    DetailRow(title: "HEIGHT", data: String(format: "%.1f m / %.1f ft", rocket.heightMeter, rocket.heightFeet))
                        .padding(.horizontal, 32)
                    
                    DetailRow(title: "DIAMETER", data: String(format: "%.1f m / %.1f ft", rocket.diameterMeter, rocket.diameterFeet))
                        .padding(.horizontal, 32)
                    
                    DetailRow(title: "MASS", data: String(format: "%.1f kg / %.1f lb", rocket.massKg, rocket.massLb))
                        .padding(.horizontal, 32)
                    
                    DetailRow(title: "PAYLOAD TO LEO", data: String(format: "%.1f kg / %.1f lb", rocket.heightMeter, rocket.heightFeet))
                        .padding(.horizontal, 32)
                    
                    DetailRow(title: "PAYLOAD TO GTO", data: String(format: "%.1f kg / %.1f lb", rocket.heightMeter, rocket.heightFeet))
                        .padding(.horizontal, 32)
                    DetailRow(title: "PAYLOAD TO MARS", data: String(format: "%.1f kg / %.1f lb", rocket.heightMeter, rocket.heightFeet))
                        .padding(.horizontal, 32)
                    
                    
                    Spacer()
                }
            }
            .navigationTitle(rocket.name)
            .navigationBarTitleDisplayMode(.inline)
            .font(Font.custom("Nasalization", size: 5))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 14, height: 23)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        
    }
}

struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RocketDetailView(rocket: .constant(MockData.sampleRocket))
        }
    }
}
