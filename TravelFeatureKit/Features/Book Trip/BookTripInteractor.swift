import UIKit
import RxSwift
import TravelKit

protocol BookTripInteractable {
    func dispatch(_ action: BookTrip.Action)
}

class BookTripInteractor: FeatureInteractor, BookTripInteractable {
    private let presenter: BookTripPresenter
    private let bookURLRepository: BookURLRepository
    private var disposeBag = DisposeBag()

    private let trip: Trip

    private var contentState: ContentState<BookTrip.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(presenter: BookTripPresenter,
         bookURLRepository: BookURLRepository,
         trip: Trip) {
        self.presenter = presenter
        self.bookURLRepository = bookURLRepository
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
        bookURLRepository.getURL(for: trip)
            .map { url in
                return BookTrip.Data(trip: self.trip, bookUrl: url)
            }
            .subscribe(
                onNext: { data in
                    self.contentState = .loaded(data: data, error: nil)
                },
                onError: { error in
                    self.contentState = .error(error: .loading(reason: error.localizedDescription))
                }
            )
            .disposed(by: disposeBag)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
