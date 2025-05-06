import SwiftUI

struct OfferDetailScreen: View {
  var offer: Offer

  var body: some View {
    offer.color
      .navigationTitle("\(Self.self)")
  }
}
