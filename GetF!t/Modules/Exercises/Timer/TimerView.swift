import SwiftUI

struct TimerView: View {
    @StateObject var timerViewModel = TimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var historyViewModel: HistoryViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ModalSheetView(text: navigationManager.titleText, circleX: 0.5, circleY: 0.18) {
                    VStack {
                        Spacer()
                        indentView
                        Spacer()
                        doneButton
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var indentView: some View {
        IndentView {
            timerText
        }
        .shadow(color: ColorProvider.dropShadow.opacity(0.5), radius: 6,
                x: timerViewModel.dropShadowParameter,
                y: timerViewModel.dropShadowParameter)
        .shadow(color: ColorProvider.dropHighlight, radius: 6,
                x: timerViewModel.dropHighlightParameter,
                y: timerViewModel.dropHighlightParameter)
    }

    private var doneButton: some View {
        RaisedButtonView(buttonText: LocalizedStringProvider.Button.done) {
            presentationMode.wrappedValue.dismiss()
            navigationManager.onDoneTapped()
            historyViewModel.onDoneTapped(navigationManager.nameForHistory())
        }
        .opacity(timerViewModel.opacity)
        .padding([.leading, .trailing], 30)
        .padding(.bottom, 60)
    }
    
    var timerText: some View {
        Text("\(timerViewModel.timeRemaining)")
            .font(.system(size: 90, design: .rounded))
            .fontWeight(.heavy)
            .frame(
                minWidth: 180,
                maxWidth: 200,
                minHeight: 180,
                maxHeight: 200)
            .padding()
            .onReceive(timerViewModel.timer, perform: timerViewModel.onTimeOver)
    }

    private func circle(size: CGSize) -> some View {
        Circle()
            .frame(
                width: size.width,
                height: size.height)
            .position(
                x: size.width * 0.5,
                y: -size.width * 0.2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
