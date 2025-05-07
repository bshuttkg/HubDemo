import SwiftUI

@MainActor
@Observable
final class HubViewModel {
  private var offers: [Offer] = [
    .init(
      id: .init(),
      color: .red,
      state: .inProgress
    ),
    .init(
      id: .init(),
      color: .blue,
      state: .inProgress
    ),
  ]

  // Top section
  var notCompletedOffers: [Offer] {
    offers.filter { !$0.isFullyCompleted }
  }

  // Bottom section
  var completedOffers: [Offer] {
    offers.filter(\.isFullyCompleted)
  }

  /// If the offer is in the `inProgress` state, update the state to `transient`
  /// - Parameter offer: The `Offer` to update
  func completeOffer(_ offer: Offer) {
    guard let index = offers.firstIndex(of: offer) else { return }
    guard offers[index].state == .inProgress else { return }
    offers[index] = offers[index].updatingState(to: .transientCompleted)
  }

  /// Move all offers in the `transient` state to `completed`
  func onAppear() {
    offers = offers.map { offer in
      guard offer.state == .transientCompleted else { return offer }
      return offer.updatingState(to: .fullyCompleted)
    }
  }
}

// MARK: - Offer + State

private extension Offer {
  var isFullyCompleted: Bool {
    state == .fullyCompleted
  }

  func updatingState(to state: State) -> Offer {
    var newOffer = self
    newOffer.state = state
    return newOffer
  }
}
