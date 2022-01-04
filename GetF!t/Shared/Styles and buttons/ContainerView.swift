import SwiftUI

struct ContainerView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(ColorProvider.background)
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 25)
                    .foregroundColor(ColorProvider.background)
            }
            content
        }
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView {
            VStack {
                RaisedButton(buttonText: LocalizedStringProvider.Button.history, action: {})
                    .padding(50)
                Button(LocalizedStringProvider.Button.history, action: {})
                    .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
            }
        }
        .padding(50)
        .previewLayout(.sizeThatFits)
    }
}
