import UIKit
import RxSwift
import TravelKit

protocol BookTripInteractable {
    func dispatch(_ action: BookTrip.Action)
}

class BookTripInteractor: FeatureInteractor, BookTripInteractable {
    private let presenter: BookTripPresenter
    private let bookURLRepository: BookURLRepository
    private let favoriteTripRepository: FavoriteTripRepository
    private let tripImageRepository: TripImageRepository
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
         favoriteTripRepository: FavoriteTripRepository,
         tripImageRepository: TripImageRepository,
         trip: Trip) {
        self.presenter = presenter
        self.bookURLRepository = bookURLRepository
        self.favoriteTripRepository = favoriteTripRepository
        self.tripImageRepository = tripImageRepository
        self.trip = trip
    }

    func dispatch(_ action: BookTrip.Action) {
        switch action {
        case .load:
            load()
        case .favorite:
            toggleFavorite()
        default:
            break
        }
    }

    func load() {
        Observable
            .combineLatest(
                bookURLRepository.getURL(for: trip),
                tripImageRepository.getImageURL(for: trip),
                favoriteTripRepository.isFavorite(trip)
            )
            .map { (url, tripImage, isFavorite) in
                return BookTrip.Data(
                    trip: self.trip,
                    tripImage: tripImage,
                    bookUrl: url,
                    isFavorite: isFavorite
                )
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

    private func toggleFavorite() {
        favoriteTripRepository.isFavorite(trip)
            .flatMap { isFavorite -> Completable in
                if isFavorite {
                    return self.favoriteTripRepository.removeFavorite(self.trip)
                } else {
                    return self.favoriteTripRepository.saveFavorite(self.trip)
                }
            }
            .subscribe { _ in self.load() }
            .disposed(by: disposeBag)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
