import UIKit
import TravelKit

typealias BookTripPresenter = FeaturePresenter<BookTripViewController, BookTripAdapter>

class BookTripAdapter: FeatureAdapter {
    typealias Content = BookTrip.Data
    typealias ViewModel = BookTrip.ViewModel

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

    func makeViewModel(viewState: ViewState<BookTrip.ViewModel.Content>) -> BookTrip.ViewModel {
        return BookTrip.ViewModel(
            state: viewState,
            title: ""
        )
    }

    func makeContentViewModel(content: BookTrip.Data) throws -> BookTrip.ViewModel.Content {
        return BookTrip.ViewModel.Content(
            header: makeHeader(content.trip),
            sectionButtons: [],
            bookButton: makeBookButton(content.trip, url: content.bookUrl)
        )
    }

    // MARK: Private

    private func makeBookButton(_ trip: Trip, url: URL) -> BookTrip.ViewModel.BookButton {
        return BookTrip.ViewModel.BookButton(
            title: "\(R.string.localizable.feedBookTitle()) \(formatCurrency(trip))",
            route: .book(url)
        )
    }

    private func makeHeader(_ trip: Trip) -> BookTripHeaderViewModel {
        return BookTripHeaderViewModel(
            title: makeTripString(trip),
            subtitle: R.string.localizable.feedBothWaysTitle(),
            imageUrl: URL(string: "https://picsum.photos/1000/1000/?image=\(arc4random_uniform(1000))")!
        )
    }

    private func makeTripString(_ trip: Trip) -> String {
        guard let from = trip.departure.city,
            let to = trip.destination.city else { return "" }

        return "\(from) \n\(to)"
    }

    private func dateRange(_ trip: Trip) -> String {
        return "\(dateFormatter.string(from: trip.departureAt)) - \(dateFormatter.string(from: trip.returnAt))"
    }

    private func formatCurrency(_ trip: Trip) -> String {
        let price = trip.price
        let currency = trip.currency
        currencyFormatter.currencyCode = currency

        return currencyFormatter.string(from: NSNumber(value: price)) ?? "\(price) \(currency)"
    }

}
