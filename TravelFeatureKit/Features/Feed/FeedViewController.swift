import UIKit

class FeedViewController: UIViewController, FeatureViewController {

    // View Model
    var viewModel: Feed.ViewModel?
    typealias ViewModel = Feed.ViewModel

    // State Views
    var errorView: UIView?
    var loadingView: UIView?
    var emptyView: UIView?

    // Properties
    private let interactor: FeedInteractor
    private let router: FeedRouter

    init(interactor: FeedInteractor, router: FeedRouter) {
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

        interactor.dispatch(Feed.Action.load)
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

extension FeedViewController {
    private func setupView() {
    }

    private func setupConstraints() {
    }
}
