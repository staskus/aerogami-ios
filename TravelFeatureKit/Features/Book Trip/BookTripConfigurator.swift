import UIKit
import TravelKit

public class BookTripConfigurator {

    private let bookURLRepository: BookURLRepository

    public init(bookURLRepository: BookURLRepository) {
        self.bookURLRepository = bookURLRepository
    }

    public func createViewController(trip: Trip) -> UIViewController {
        let adapter = BookTripAdapter()
        let presenter = BookTripPresenter(adapter: adapter)
        let interactor = BookTripInteractor(
            presenter: presenter,
            bookURLRepository: bookURLRepository,
            trip: trip
        )
        let router = BookTripRouter()
        let viewController = BookTripViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
