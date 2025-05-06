import SwiftUI

struct HubView: View {
  @State private var viewModel = HubViewModel()
  var onPushOfferDetails: (Offer) -> Void

  var body: some View {
    List {
      SectionView(
        title: "not_completed",
        offers: viewModel.notCompletedOffers,
        viewModel: viewModel,
        onPushOfferDetails: onPushOfferDetails
      )
      SectionView(
        title: "completed",
        offers: viewModel.completedOffers,
        viewModel: viewModel,
        onPushOfferDetails: onPushOfferDetails
      )
    }
    .listStyle(PlainListStyle())
    .navigationTitle("\(Self.self)")
    .onAppear {
      viewModel.onAppear()
    }
  }
}

// MARK: - SectionView

private struct SectionView: View {
  var title: LocalizedStringKey
  var offers: [Offer]
  var viewModel: HubViewModel
  var onPushOfferDetails: (Offer) -> Void

  private func onOfferTapped(_ offer: Offer) {
    viewModel.completeOffer(offer)
    if offer.state == .transient {
      onPushOfferDetails(offer)
    }
  }

  var body: some View {
    Section(content: {
      if offers.isEmpty {
        EmptySectionView()
      } else {
        ForEach(offers) { offer in
          Button(action: {
            withAnimation {
              onOfferTapped(offer)
            }
          }, label: {
            offer
          })
        }
      }
    }, header: {
      Text(title)
        .lineLimit(1)
        .padding(.horizontal, 20)
    })
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
  }
}

// MARK: - EmptySectionView

private struct EmptySectionView: View {
  var body: some View {
    Text("empty")
      .lineLimit(1)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(20)
      .background(Color(white: 0.9))
  }
}
