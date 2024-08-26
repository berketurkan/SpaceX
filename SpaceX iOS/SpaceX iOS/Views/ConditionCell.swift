//
//  ConditionCell.swift
//  SpaceX iOS
//
//  Created by Vestel on 26.08.2024.
//

import SwiftUI

struct ConditionCell: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Muli", size: 18))
                .bold()
                .foregroundColor(.white)
                .padding(.leading, 25)
            
            ScrollView {
                Text(description)
                    .font(.custom("Muli", size: 15))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 18)
            }
            .frame(width: UIScreen.main.bounds.width - 15, height: 155)
            .padding(.horizontal, 10)
            .offset(y: -10)
            
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 200)
        .background(Color.white.opacity(0.1))
    }
}




struct ConditionCell_Previews: PreviewProvider {
    static var previews: some View {
        ConditionCell(
            title: "Membership Agreement",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis porta orci, id semper neque. Morbi vehicula odio sit amet libero pretium dapibus. Sed vel feugiat dolor. Nullam at eros nibh. Duis vehicula venenatis massa vel mattis. Suspendisse venenatis suscipit elit, id tincidunt sapien eleifend eu. Proin rhoncus semper arcu id rutrum. Donec sit amet magna ultricies massa molestie laoreet sed vitae risus."
        )
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
