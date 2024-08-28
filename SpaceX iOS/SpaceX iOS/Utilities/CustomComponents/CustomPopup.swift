import SwiftUI

struct CustomPopup: View {
    var width: CGFloat = 300
    var height: CGFloat = 400
    var imageWidth: CGFloat = 50
    var imageHeight: CGFloat = 50
    var backgroundColor: Color = Color.gray
    var title: String
    var description: String? = nil
    var buttonText: String? = nil
    var buttonWidth: CGFloat = 150
    var buttonHeight: CGFloat = 50
    var buttonColor: Color = Color("lightGreen") // Default button color
    var imageName: String
    var onButtonTap: (() -> Void)? = nil
    var onAppearAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth, height: imageHeight)
                .padding(.top, 20)
            
            Text(title)
                .font(.custom("Muli", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            
            if let description = description {
                Text(description)
                    .font(.custom("Muli", size: 15))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                
            }
            
            if let buttonText = buttonText {
                Button(action: {
                    onButtonTap?()
                }) {
                    Text(buttonText)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(buttonColor)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
            }
            
            Spacer()
        }
        .frame(width: width, height: height)
        .background(backgroundColor)
        .cornerRadius(20)
        .shadow(radius: 10)
        .onAppear {
            onAppearAction?()         }
    }
}

struct CustomPopup_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomPopup(
            width: 300,
            height: 300,
            imageWidth: 80,
            imageHeight: 80,
            backgroundColor: Color.gray,
            title: "Important Message",
            description: "This is a description for the custom popup. It can be optional.",
            buttonText: "OK",
            buttonWidth: 200,
            buttonHeight: 50,
            buttonColor: Color("lightGreen"),
            imageName: "activationEmailIcon"
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
