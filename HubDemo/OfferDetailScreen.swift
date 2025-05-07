import SwiftUI

struct OfferDetailScreen: View {
  var offer: Offer

  var body: some View {
    offer.color
      .ignoresSafeArea(edges: .bottom)
      .navigationTitle("\(Self.self)")
      .navigationBarTitleDisplayMode(.inline)
  }
}
