import SwiftUI

struct LocalizedStringProvider {
    struct ExercisesNames {
        static let burpee = LocalizedStringKey("Burpee")
        static let squat = LocalizedStringKey("Squat")
        static let stepUp = LocalizedStringKey("StepUp")
        static let sunSalute = LocalizedStringKey("SunSalute")
    }

    struct Button {
        static let getStarted = LocalizedStringKey("GetStarted")
        static let startExercise = LocalizedStringKey("StartExercise")
        static let done = LocalizedStringKey("Done")
        static let history = LocalizedStringKey("History")
        static let `continue` = LocalizedStringKey("Continue")
    }

    struct WelcomePage {
        static let welcome = LocalizedStringKey("Welcome")
        static let getfit = LocalizedStringKey("Getf!t")
        static let getfitPostScript = LocalizedStringKey("GetfitPostScript")
        static let history = LocalizedStringKey("History")
        static let `continue` = LocalizedStringKey("Continue")
    }

    struct SuccesPage {
        static let success = LocalizedStringKey("Success")
        static let glory = LocalizedStringKey("Glory")
        static let gloryPostScript = LocalizedStringKey("GloryPostScript")
    }
    
    struct Errors {
        static let couldntFind = LocalizedStringKey("CouldntFind")
        static let loadingError1 = LocalizedStringKey("LaodingError1")
        static let loadingError2 = LocalizedStringKey("LoadingError2")
    }

    struct Settings {
        static let settings = LocalizedStringKey("settings")
        static let exerciseInterval = LocalizedStringKey("exerciseInterval")
        static let orderInterval = LocalizedStringKey("exerciseOrder")
    }

    struct texts {
        static let rating = LocalizedStringKey("rating")
        static let ratingButton = LocalizedStringKey("ratingButton")
    }
}
