//
//  RocketDetailView.swift
//  SpaceX iOS
//
//  Created by Vestel on 15.08.2024.
//

import SwiftUI

struct RocketDetailView: View {
    
    @Binding var rocket: Rocket
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: RocketListViewModel
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 450, height: 900)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 8)
            
            VStack {
                ScrollView {
                    HStack(spacing: 15) {
                        RocketRemoteImage(urlString: rocket.imageURL)
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 275, height: 175)
                            .padding(.top, 120)
                            .padding(.trailing, 0)
                        
                        Button {
                            viewModel.toggleFavorite(for: rocket)
                            //rocket.toggleFavorite()
                        } label: {
                            Image("FavButton")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(rocket.isFavorite ? Color("lightGreen") : .white)
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .padding(.top, -25)
                        }
                    }
                    
                    Text(rocket.description)
                        .padding(.horizontal, 48)
                        .padding(.top, 25)
                        .foregroundColor(.white)
                        .font(Font.custom("Muli", size: 16))
                    
                    DetailRow(
                        title: "HEIGHT",
                        data: String(format: "%.1f m / %.1f ft", rocket.height.meters, rocket.height.feet)
                    )
                    .padding(.horizontal, 32)
                    
                    DetailRow(
                        title: "DIAMETER",
                        data: String(format: "%.1f m / %.1f ft", rocket.diameter.meters, rocket.diameter.feet)
                    )
                    .padding(.horizontal, 32)
                    
                    DetailRow(
                        title: "MASS",
                        data: String(format: "%.1f kg / %.1f lb", rocket.mass.kg, rocket.mass.lb)
                    )
                    .padding(.horizontal, 32)
                    
                    ForEach(rocket.payload_weights) { payload in
                        DetailRow(
                            title: payload.name.uppercased(),
                            data: String(format: "%.1f kg / %.1f lb", Double(payload.kg), Double(payload.lb))
                        )
                        .padding(.horizontal, 32)
                    }
                }
                .frame(minHeight: 550)
                Spacer(minLength: 0)
                
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                            ForEach(rocket.flickr_images, id: \.self) { imageUrl in
                                RocketRemoteImage(urlString: imageUrl)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: (UIScreen.main.bounds.width - 25) / 2,
                                           height: 200
                                    )
                                    .clipped()
                                    
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
                
                Spacer(minLength: 150)
                
            }
            .navigationTitle(rocket.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarModifier(
                backgroundColor: .clear,
                foregroundColor: UIColor(named: "lightGreen") ?? .white,
                font: UIFont(name: "Nasalization", size: 20)!,
                withSeparator: false
            )
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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

//struct RocketDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            RocketDetailView(rocket: MockData.sampleRocket)
//        }
//    }
//}
