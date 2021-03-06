import SwiftUI

class ExerciseManager: ObservableObject {
    let exercise: Exercise

    init(exercise: Exercise) {
        self.exercise = exercise
        rating = UserDefaults.standard.integer(forKey: "\(exercise.name)")
    }

    // MARK: - timerView
    @Published var timeRemaining = 3

    var timeOver: Bool {
        timeRemaining == 0
    }

    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common)
        .autoconnect()

    var dropShadowParameter: CGFloat {
        timeOver ? 6 : -6
    }

    var dropHighlightParameter: CGFloat {
        timeOver ? -6 : 6
    }

    func onTimeOver(_ timerValue: Date) -> Void {
        if timeOver {
            timer.upstream.connect().cancel()
        } else {
            timeRemaining -= 1
        }
    }

    // MARK: - exerciseView
    @Published var isShowingTimer = false

    var videoURL: URL? {
        Bundle.main.url(
            forResource: exercise.videoName,
            withExtension: "mp4"
        )
    }

    func onStartExerciseTapped() {
        isShowingTimer = true
    }
    
    // MARK: - ratingView
    @Published var rating = 0

    let maximumRating = 5

    let onColor = ColorProvider.ratings
    let offColor = Color.gray

    func ratingActive(_ index: Int) -> Bool {
        index > rating
    }

    func updateRating(index: Int) {
        rating = index
        UserDefaults.standard.set(rating, forKey: "\(exercise.name)")
        print("sejf\(rating)")
    }
}
