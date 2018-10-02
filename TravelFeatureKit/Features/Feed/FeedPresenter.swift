import UIKit
import TravelKit

typealias FeedPresenter = FeaturePresenter<FeedViewController, FeedAdapter>

class FeedAdapter: FeatureAdapter {
    typealias Content = Feed.Data
    typealias ViewModel = Feed.ViewModel

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat =  DateFormatter.dateFormat(fromTemplate: "MM/dd", options: 0, locale: Locale.current)
        return formatter
    }()

    func makeViewModel(viewState: ViewState<Feed.ViewModel.Content>) -> Feed.ViewModel {
        return Feed.ViewModel(
            state: viewState,
            title: ""
        )
    }

    func makeContentViewModel(content: Feed.Data) throws -> Feed.ViewModel.Content {
        return Feed.ViewModel.Content(
            rows: makeFeedCardRows(content)
        )
    }

    private func makeFeedCardRows(_ content: Feed.Data) -> [FeedCardViewModel] {
        return content.trips.map { trip in
            currencyFormatter.currencyCode = trip.currency
            return FeedCardViewModel(
                direction: R.string.localizable.feedBothWaysTitle(),
                trip: makeTripString(trip),
                price: formatCurrency(trip),
                dateRange: dateRange(trip),
                routeName: R.string.localizable.feedBookTitle(),
                imageUrl: URL(string: "https://picsum.photos/1000/1000/?image=\(arc4random_uniform(1000))")!,
                route: Feed.Route.book
            )
        }
    }

    private func makeTripString(_ trip: Trip) -> String {
        guard let from = trip.departure.city,
            let to = trip.destination.city else { return "" }

        return "\(from) -\n\(to)"
    }

    private func dateRange(_ trip: Trip) -> String {
        return "\(dateFormatter.string(from: trip.departureAt)) - \(dateFormatter.string(from: trip.returnAt))"
    }

    private func formatCurrency(_ trip: Trip) -> String {
        guard let currency = trip.currency else { return "" }

        let price = trip.price
        currencyFormatter.currencyCode = currency

        return currencyFormatter.string(from: NSNumber(value: price)) ?? "\(price) \(currency)"
    }
}
