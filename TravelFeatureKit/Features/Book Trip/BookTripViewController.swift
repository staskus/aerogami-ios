import UIKit
import SnapKit

class BookTripViewController: UIViewController, FeatureViewController {

    // View Model
    var viewModel: BookTrip.ViewModel?
    typealias ViewModel = BookTrip.ViewModel
    typealias Interactor = BookTripInteractor & BookTripInteractable

    // State Views
    var errorView: UIView?
    var loadingView: UIView?
    var emptyView: UIView?

    // Properties
    private let interactor: Interactor
    private let router: BookTripRouter

    init(interactor: Interactor, router: BookTripRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStateViews()
        setupView()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        interactor.subscribe()

        interactor.dispatch(BookTrip.Action.load)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.unsubscribe()
    }

    func display() {

    }

    // MARK: - Required Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookTripViewController {
    private func setupView() {
    }

    private func setupConstraints() {
    }
}
