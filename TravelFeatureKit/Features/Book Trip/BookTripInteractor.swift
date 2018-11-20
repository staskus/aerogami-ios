import UIKit
import RxSwift
import TravelKit

protocol BookTripInteractable {
    func dispatch(_ action: BookTrip.Action)
}

class BookTripInteractor: FeatureInteractor, BookTripInteractable {
    private let presenter: BookTripPresenter
    private var disposeBag = DisposeBag()

    private let trip: Trip

    private var contentState: ContentState<BookTrip.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(presenter: BookTripPresenter, trip: Trip) {
        self.presenter = presenter
        self.trip = trip
    }

    func dispatch(_ action: BookTrip.Action) {
        switch action {
        case .load:
            load()
        default:
            break
        }
    }

    func load() {
        contentState = .loaded(data: BookTrip.Data(trip: trip), error: nil)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
