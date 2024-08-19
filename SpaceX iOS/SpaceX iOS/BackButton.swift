//
//  BackButton.swift
//  SpaceX iOS
//
//  Created by Vestel on 15.08.2024.
//

import SwiftUI

struct BackButton: View {
    
    var action: () -> Void
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)

        }
        .frame(width: width, height: height)

    }
    
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(action: {},
                   width: 30,
                   height: 30)
    }
}
