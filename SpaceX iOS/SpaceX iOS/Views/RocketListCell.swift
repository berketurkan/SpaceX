//
//  RocketListCell.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct RocketListCell: View {
    
    @Binding var selectedRocket: Rocket?
    @State var rocket: Rocket
    
    var body: some View {
        VStack {
            HStack {
                Text(rocket.name)
                    .font(Font.custom("Nasalization", size: 17))
                    .foregroundColor(selectedRocket?.id == rocket.id ? Color("lightGreen") : .white)
                    .padding(.top, 0)
                    .padding(.trailing, 15)
                
                Spacer()
                
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
                .padding(.trailing,0)
                .padding(.top,0)
            }
            .padding(.trailing,0)
            .padding(.top,0)
            
            Image(rocket.imageURL)
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 250, height: 100)
                .padding(.top, 10)
        }
        .padding()
        .frame(width: 359, height: 180)
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(rocket.id == selectedRocket?.id ? Color("lightGreen") : Color.clear, lineWidth: 1))
        .onTapGesture {
            selectedRocket = rocket
        }
        
    }
}

struct RocketListCell_Previews: PreviewProvider {
    static var previews: some View {
        RocketListCell(selectedRocket: .constant(MockData.sampleRocket1), rocket: MockData.sampleRocket1)
    }
}
