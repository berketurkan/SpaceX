//
//  LaunchDetailView.swift
//  SpaceX iOS
//
//  Created by Vestel on 25.08.2024.
//

import SwiftUI

struct LaunchDetailView: View {
    let launch: Launch
    let backgroundImageName: String
    let index: Int
    @Environment(\.presentationMode) private var presentationMode
    
    private var isLeftAligned: Bool {
        return index % 3 == 1
    }
    
    var body: some View {
        ZStack {
            Image("SpaceXBackGround")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 850)
                .edgesIgnoringSafeArea(.all)
            
            Image(backgroundImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 350)
                .clipped()
                .blendMode(.screen)
                .padding(.bottom, 300)
            
            VStack {
                Spacer(minLength: 50)
                
                VStack(alignment: isLeftAligned ? .leading : .trailing, spacing: 5) {
                    Text(launch.name)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Flight Number: \(launch.flightNumber)")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity, alignment: isLeftAligned ? .leading : .trailing)
                .padding(isLeftAligned ? .leading : .trailing, 10)
                
                HStack(spacing: 30) {
                    VStack {
                        Text(extractDay(from: launch.dateLocal))
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                        Text("DAY")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    VStack {
                        Text(extractMonth(from: launch.dateLocal))
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                        Text("MONTH")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    VStack {
                        Text(extractYear(from: launch.dateLocal))
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                        Text("YEAR")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.top, 125)
                
                Text("Falcon 9")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color("lightGreen"))
                    .padding(.top, 40)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
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
    
    private func extractDay(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[2].prefix(2))
    }
    
    private func extractMonth(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[1])
    }
    
    private func extractYear(from dateString: String) -> String {
        let components = dateString.split(separator: "-")
        return String(components[0])
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailView(
            launch: Launch.mockDataLaunch,
            backgroundImageName: "upcoming2",
            index: 1
        )
    }
}


