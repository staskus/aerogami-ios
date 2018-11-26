import UIKit
import TravelKit

public class BookTripConfigurator {

    private let bookURLRepository: BookURLRepository
    private let favoriteTripRepository: FavoriteTripRepository
    private let tripImageRepository: TripImageRepository

    public init(
        bookURLRepository: BookURLRepository,
        favoriteTripRepository: FavoriteTripRepository,
        tripImageRepository: TripImageRepository) {
        self.bookURLRepository = bookURLRepository
        self.favoriteTripRepository = favoriteTripRepository
        self.tripImageRepository = tripImageRepository
    }

    public func createViewController(trip: Trip) -> UIViewController {
        let adapter = BookTripAdapter()
        let presenter = BookTripPresenter(adapter: adapter)
        let interactor = BookTripInteractor(
            presenter: presenter,
            bookURLRepository: bookURLRepository,
            favoriteTripRepository: favoriteTripRepository,
            tripImageRepository: tripImageRepository,
            trip: trip
        )
        let router = BookTripRouter()
        let viewController = BookTripViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
