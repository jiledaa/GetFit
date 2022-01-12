import SwiftUI
import AVKit

struct ExerciseView: View {
    @EnvironmentObject var navigationManager: NavigationManager    
    @StateObject var exerciseManager = ExerciseManager()

    let exercise: Exercise

    var body: some View {
        VStack {
            Spacer()
            ContainerView {
                VStack {
                    video
                        .padding(.bottom)
                    startExerciseButton
                        .padding(.bottom, 40)
                    VStack {
                        Text(LocalizedStringProvider.texts.rating)
                            .italic()
                        HStack {
                            rating
                        }

                    }
                    .padding(.vertical)
                }
            }
        }
        .sheet(isPresented: $exerciseManager.isShowingTimer) {
            TimerView(exerciseManager: exerciseManager)
        }
        .onAppear {
            exerciseManager.loadRating(exercise: exercise)
        }
    }

    @ViewBuilder
    private var video: some View {
        if let url = exerciseManager.videoURL {
            VideoPlayer(player: AVPlayer(url: url))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(20)
        } else {
            Text(LocalizedStringProvider.Errors.couldntFind)
                .foregroundColor(.red)
        }
    }

    private var startExerciseButton: some View {
        RaisedButtonView(buttonText: LocalizedStringProvider.Button.startExercise) {
            exerciseManager.onStartExerciseTapped()
        }
        .frame(width: 250, height: 50, alignment: .center)
    }

    private var rating: some View {
        ForEach(1 ..< exerciseManager.maximumRating + 1, id: \.self) { index in
            Button(action: {
//                ratingViewModel.updateRating(index: index)
            }) {
                ImageProvider.waveform
                    .foregroundColor(
                        exerciseManager.ratingActive(index) ? exerciseManager.offColor :   exerciseManager.onColor)
                    .font(.title3)
            }
            .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(exerciseManager: .init(), exercise: .exercises[0])
            .environmentObject(HistoryViewModel())
    }
}
