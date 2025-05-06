import SwiftUI

struct ContentView: View {
  @State private var path = NavigationPath()

  var body: some View {
    NavigationStack(path: $path) {
      HubView(onPushOfferDetails: { offer in
        path.append(offer)
      })
      .navigationDestination(for: Offer.self) { offer in
        OfferDetailScreen(offer: offer)
      }
    }
  }
}

// MARK: - Preview

#Preview {
  ContentView()
}
