//
//  DetailRow.swift
//  SpaceX iOS
//
//  Created by Vestel on 15.08.2024.
//

import SwiftUI

struct DetailRow: View {
    var title: String
    var data: String
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray.opacity(0.9))
            
            HStack {
                Text(title)
                    .font(Font.custom("Muli", size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 18)
                
                Text(data)
                    .font(Font.custom("Muli", size: 14))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing) 
                    .padding(.trailing, 18)
            }
            .frame(height: 35) //height of the row
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(title: "title", data: "data")
    }
}
