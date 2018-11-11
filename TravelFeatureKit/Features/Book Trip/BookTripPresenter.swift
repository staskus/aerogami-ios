import UIKit
import TravelKit

typealias BookTripPresenter = FeaturePresenter<BookTripViewController, BookTripAdapter>

class BookTripAdapter: FeatureAdapter {
    typealias Content = BookTrip.Data
    typealias ViewModel = BookTrip.ViewModel

    func makeViewModel(viewState: ViewState<BookTrip.ViewModel.Content>) -> BookTrip.ViewModel {
        return BookTrip.ViewModel(
            state: viewState,
            title: ""
        )
    }

    func makeContentViewModel(content: BookTrip.Data) throws -> BookTrip.ViewModel.Content {
        return BookTrip.ViewModel.Content()
    }
}
