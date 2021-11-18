import SwiftUI

struct RatingView: View {
  let exerciseIndex: Int
  @AppStorage("ratings") private var ratings = ""
  @State private var rating = 0
  let maximumRating = 5

  let onColor = Color.red
  let offColor = Color.gray

  init(exerciseIndex: Int) {
    self.exerciseIndex = exerciseIndex
    let desiredLength = Exercise.exercises.count
    if ratings.count < desiredLength {
      ratings = ratings.padding(
        toLength: desiredLength,
        withPad: "0",
        startingAt: 0)
    }
  }

  fileprivate func convertRating() {
    let index = ratings.index(
      ratings.startIndex,
      offsetBy: exerciseIndex)
    let character = ratings[index]
    rating = character.wholeNumberValue ?? 0
  }

  var body: some View {
   
     
      VStack {
          HStack {
                  ForEach(1 ..< maximumRating + 1) { index in
                    Image(systemName: "waveform.path.ecg")
                      .foregroundColor(
                        index > rating ? offColor : onColor)
                      .onTapGesture {
                        updateRating(index: index)
                      }
                      .onChange(of: ratings) { _ in
                        convertRating()
                      }
                      .onAppear {
                        convertRating()
                      }
                  }
                }
          .font(.largeTitle)
          .padding(-5)


      HStack {
      Image(systemName: "battery.100")
          .foregroundColor(.green)
          .font(.system(size: 35))
          .padding(10)
      Image(systemName: "battery.50")
          .foregroundColor(.green)
          .font(.system(size: 35))
          .padding(10)
      Image(systemName: "battery.0")
          .foregroundColor(.green)
          .font(.system(size: 35))
          .padding(10)
      }.padding(-5)
      }
  }
  func updateRating(index: Int) {
    rating = index
    let index = ratings.index(
      ratings.startIndex,
      offsetBy: exerciseIndex)
    ratings.replaceSubrange(index...index, with: String(rating))
  }
}

struct RatingView_Previews: PreviewProvider {
  @AppStorage("ratings") static var ratings: String?
  static var previews: some View {
    ratings = nil
    return RatingView(exerciseIndex: 0)
      .previewLayout(.sizeThatFits)
  }
}
