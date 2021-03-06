import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack {
            Text(navigationManager.titleText)
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
            HStack {
                ForEach(0 ..< Exercise.allCases.count) { tab in
                    ZStack {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                            .opacity(navigationManager.opacity(tab))
                        Circle()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        navigationManager.goTo(tab: tab)
                    }
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
                .previewLayout(.sizeThatFits)
            HeaderView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewLayout(.sizeThatFits)
        }
    }
}
