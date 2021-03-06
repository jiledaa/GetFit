import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var selectedTab = -1
    @Published var titleText: LocalizedStringKey = LocalizedStringProvider.WelcomePage.welcome
    @Published var modal: Modal?
    // MARK: - navigation
    let maxTabs = Exercise.allCases.count
    var titles = [LocalizedStringKey]()

    init() {
        // titleText is now computed from selectedTab
        $selectedTab
            .map(nameForTitle(tab:))
            .assign(to: &$titleText)
    }
    
    private func nameForTitle(tab: Int) -> LocalizedStringKey {
        if (0..<titles.count).contains(tab) {
            return titles[tab]
        }
        
        return LocalizedStringProvider.WelcomePage.welcome
    }

    func nameForHistorySave() -> String {
        switch titleText {
        case LocalizedStringProvider.ExercisesNames.squat: return StringProvider.ExercisesNamesVideo.squat
        case LocalizedStringProvider.ExercisesNames.stepUp: return StringProvider.ExercisesNamesVideo.stepUp
        case LocalizedStringProvider.ExercisesNames.burpee: return StringProvider.ExercisesNamesVideo.burpee
        default: return StringProvider.ExercisesNamesVideo.sunSalute
        }
    }

    func goToWelcomeView() {
        selectedTab = -1
    }

    func goToFirstTab() {
        selectedTab = 0
    }

    // only called from welcome view and timer view
    func goToNextTab() {
        if selectedTab + 1 == maxTabs {
            // TODO: cekovat pri novych verzich
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
                self?.modal = .success
            }
        } else {
            selectedTab += 1
        }
    }

    func goTo(tab: Int) {
        selectedTab = tab
    }

    // MARK: - convenience methods

    func onShowHistoryTapped() {
        modal = .history
    }

    func onShowSettingsTapped() {
        modal = .settings
    }

    func onDoneTapped() {
        goToNextTab()
    }

    // MARK: - UI helpers

    // tab indicator opacity
    func opacity(_ tab: Int) -> Double {
        tab == selectedTab ? 0.5 : 0
    }

    // MARK: - history

    @Published var showHistory = false
    var showHistoryToggle: () {
        showHistory.toggle()
    }

    var addDoneExercise: ((LocalizedStringKey) -> Void)?
    
    // MARK: - titles
    func updateTitles(_ exercises: [Exercise]) {
        titles = exercises.map(\.name)
        titleText = nameForTitle(tab: selectedTab)
    }
}



