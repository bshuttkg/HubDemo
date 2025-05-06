import SwiftUI

// MARK: - Offer (Model)

struct Offer: Identifiable, Hashable {
  enum State: Hashable {
    case inProgress // Aka portrait
    case transient // Completed but on the screen!
    case completed // Aka landscape
  }

  var id: UUID
  var color: Color
  var state: State

  // Use switch instead of != to ensure programmer edits if a case is added
  var isFinished: Bool {
    switch state {
    case .inProgress:
      false
    case .transient, .completed:
      true
    }
  }
}

// MARK: - Offer (View)

extension Offer: View {
  private var imageName: String {
    switch state {
    case .inProgress:
      "xmark.circle.fill"
    case .transient:
      "pencil.circle.fill"
    case .completed:
      "checkmark.circle.fill"
    }
  }

  private var title: LocalizedStringKey {
    switch state {
    case .inProgress:
      "in_progress"
    case .transient:
      "transient"
    case .completed:
      "completed"
    }
  }

  private var height: CGFloat {
    switch state {
    case .completed:
      100
    case .inProgress, .transient:
      200
    }
  }

  private var backgroundColor: Color {
    isFinished ? .white : color
  }

  private var foregroundColor: Color {
    isFinished ? color : .white
  }

  private var borderColor: Color? {
    isFinished ? color : nil
  }

  var body: some View {
    backgroundColor
      .frame(maxWidth: .infinity)
      .frame(height: height)
      .overlay {
        VStack(spacing: 10) {
          Image(systemName: imageName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .symbolEffect(.bounce, value: state)

          Text(title)
            .lineLimit(1)
        }
        .foregroundStyle(foregroundColor)
      }
      .overlay {
        if let borderColor {
          Rectangle()
            .strokeBorder(borderColor, lineWidth: 5)
        }
      }
      .compositingGroup()
      .animation(.smooth, value: state)
  }
}
