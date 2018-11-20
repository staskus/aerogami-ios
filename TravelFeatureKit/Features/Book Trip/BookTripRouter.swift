import UIKit
import SafariServices

class BookTripRouter {
    weak var viewController: BookTripViewController?

    init() {
    }

    func route(to route: BookTrip.Route) {
        switch route {
        case .book(let url):
            open(url: url)
        }
    }

    private func open(url: URL) {
        let sfViewController = SFSafariViewController(url: url)
        viewController?.present(sfViewController, animated: true, completion: nil)
    }
}
