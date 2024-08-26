//
//  AcceptRow.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct AcceptRow: View {
    @Binding var isAccepted: Bool
    var text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                isAccepted.toggle()
            } label: {
                Image(isAccepted ? "filledCheckIcon" : "emptyCheckIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            
            Text(text)
                .font(.custom("Muli", size: 13))
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
        .background(Color.clear)
    }
}

struct AcceptRow_Previews: PreviewProvider {
    @State static var isAccepted1 = true
    
    static var previews: some View {
        VStack {
            AcceptRow(isAccepted: $isAccepted1, text: "I have read and accept to Membership Contract.")
            AcceptRow(isAccepted: $isAccepted1, text: "I have read and accept to Privacy Policy.")
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
