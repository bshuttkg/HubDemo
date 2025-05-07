import SwiftUI

// MARK: - Offer (Model)

struct Offer: Identifiable, Hashable {
  enum State: Hashable {
    case inProgress // Aka portrait
    case transientCompleted // Completed, but still portrait!
    case fullyCompleted // Aka landscape
  }

  var id: UUID
  var color: Color
  var state: State

  // Use switch instead of != to ensure programmer edits if a case is added
  var isCompleted: Bool {
    switch state {
    case .inProgress:
      false
    case .transientCompleted, .fullyCompleted:
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
    case .transientCompleted:
      "pencil.circle.fill"
    case .fullyCompleted:
      "checkmark.circle.fill"
    }
  }

  private var title: LocalizedStringKey {
    switch state {
    case .inProgress:
      "in_progress"
    case .transientCompleted:
      "transient"
    case .fullyCompleted:
      "completed"
    }
  }

  private var height: CGFloat {
    switch state {
    case .inProgress, .transientCompleted:
      200
    case .fullyCompleted:
      100
    }
  }

  private var backgroundColor: Color {
    isCompleted ? .white : color
  }

  private var foregroundColor: Color {
    isCompleted ? color : .white
  }

  private var borderColor: Color? {
    isCompleted ? color : nil
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
