import SwiftUI

struct RatingView: View {
    @ObservedObject var exerciseManager: ExerciseManager
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var animationAmount = 1.0

    var body: some View {
        VStack {
            Text(LocalizedStringProvider.Button.done)
                .font(.largeTitle)
            Text(LocalizedStringProvider.texts.ratingButton)
                .italic()
            HStack {
                ratingButton
            }
            .shadow(color: ColorProvider.dropShadow, radius: 1, x: -2, y: 2)
            .shadow(color: ColorProvider.dropHighlight, radius: 1, x: -2, y: -2)
        }
        .padding(.vertical)
        .opacity(exerciseManager.timeOver ? 1 : 0)
        .animation(.easeInOut(duration: 1), value: exerciseManager.timeOver)
    }

    private var ratingButton: some View {
        ForEach(1 ..< exerciseManager.maximumRating + 1, id: \.self) { index in
            Button(action: {
                exerciseManager.updateRating(index: index)
                historyViewModel.onDoneTapped(navigationManager.nameForHistorySave(), exerciseManager.rating)
                presentationMode.wrappedValue.dismiss()
                navigationManager.onDoneTapped()
            })
            {
                ImageProvider.waveform
                    .foregroundColor(exerciseManager.offColor)
                    .font(.title3)
            }
            .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
            .overlay(
                Circle()
                    .stroke(.purple)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        return RatingView(exerciseManager: .init(exercise: .stepUp))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
