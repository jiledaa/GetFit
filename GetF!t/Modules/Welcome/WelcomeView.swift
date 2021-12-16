import SwiftUI

struct WelcomeView: View {
    @State private var showHistory = false
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab,
                    titleText: LocalizedStringProvider.WelcomePage.welcome
                )
                Spacer()
                VStack {
                    WelcomeView.images
                        .padding(150)
                    getStartedButton
                    Spacer()
                    historyButton
                        .sheet(isPresented: $showHistory) {
                            HistoryView(showHistory: $showHistory)
                        }
                }
                
                .frame(height: geometry.size.height * 0.7)
            }
        }
    }
    
    var getStartedButton: some View {
        RaisedButton(buttonText: LocalizedStringProvider.Button.getStarted) {
            selectedTab = 0
        }
        .frame(width: 250, height: 50, alignment: .center)
        .padding(40)
    }
    
    var historyButton: some View {
        Button(action: {
            showHistory.toggle()
        }) {
            Text(LocalizedStringProvider.Button.history)
                .fontWeight(.bold)
                .padding([.leading, .trailing], 5)
        }

        .padding(.bottom, 200)
        .buttonStyle(EmbossedButtonStyle())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(selectedTab: .constant(9))
    }
}
