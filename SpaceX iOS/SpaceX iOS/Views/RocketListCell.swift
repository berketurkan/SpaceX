//
//  RocketListCell.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct RocketListCell: View {
    @Binding var rocket: Rocket
    var isTapAnimating: Bool
    //@ObservedObject var viewModel: RocketListViewModel
    
    var body: some View {
        VStack {
            
            Spacer(minLength: 10)
            
            HStack {
                Text(rocket.name)
                    .font(Font.custom("Nasalization", size: 17))
                    .foregroundColor(isTapAnimating ? Color("lightGreen") : .white)
                    .padding(.top, 0)
                    .padding(.trailing, 15)
                
                Spacer()
                
                Button {
                    //viewModel.toggleFavorite(for: rocket)
                    rocket.toggleFavorite()
                } label: {
                    Image("FavButton")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(rocket.isFavorite ? Color("lightGreen") : .white)
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                }
            }
            
            Spacer(minLength: 0)
            
            RocketRemoteImage(urlString: rocket.imageURL)
                .aspectRatio( contentMode: .fit)
                .frame(width: 600, height: 140)
                .padding(.top, 10)
            
            Spacer(minLength: 15)
        }
        .padding()
        .frame(width: 359, height: 200)
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isTapAnimating ? Color("lightGreen") : Color.clear, lineWidth: 1)
        )
    }
}

//struct RocketListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RocketListCell(rocket: MockData.sampleRocket1, isTapAnimating: false)
//    }
//}
