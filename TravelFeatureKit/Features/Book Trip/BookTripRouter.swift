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
        case .share(let text):
            let shareController = UIActivityViewController(activityItems: [text], applicationActivities: [])
            viewController?.present(shareController, animated: true, completion: nil)
        }
    }

    private func open(url: URL) {
        let sfViewController = SFSafariViewController(url: url)
        viewController?.present(sfViewController, animated: true, completion: nil)
    }
}
