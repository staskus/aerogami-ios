import UIKit

class FeedRouter {

    private let bookTripConfigurator: BookTripConfigurator

    weak var viewController: FeedViewController?

    init(bookTripConfigurator: BookTripConfigurator) {
        self.bookTripConfigurator = bookTripConfigurator
    }

    func route(to route: Feed.Route) {
        switch route {
        case .book(let trip):
            let bookTripViewController = bookTripConfigurator.createViewController(trip: trip)
            bookTripViewController.modalPresentationStyle = .overCurrentContext
            bookTripViewController.modalTransitionStyle = .coverVertical
            viewController?.present(bookTripViewController, animated: true, completion: nil)
        }
    }
}
