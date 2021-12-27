import SwiftUI

struct ContentView: View {
    @StateObject var selectedTabManager = SelectedTabManager()

    var body: some View {
        ZStack {
            GradientBackground()
            TabView(selection: $selectedTabManager.selectedTab) {
                WelcomeView(welcomeViewModel: WelcomeViewModel.init())
                    .tag(9)
                ForEach(0 ..< Exercise.exercises.count) { index in
                    // TODO: predelat ViewModel
                    ExerciseView(exerciseViewModel: ExercisesViewModel.init(index: 0))
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .environmentObject(selectedTabManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
