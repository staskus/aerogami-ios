import UIKit
import SnapKit

class PreferencesViewController: UIViewController, FeatureViewController {

    // View Model
    var viewModel: Preferences.ViewModel?
    typealias ViewModel = Preferences.ViewModel

    // State Views
    var errorView: UIView?
    var loadingView: UIView?
    var emptyView: UIView?

    // Properties
    private let interactor: PreferencesInteractor
    private let router: PreferencesRouter

    init(interactor: PreferencesInteractor, router: PreferencesRouter) {
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

        interactor.dispatch(Preferences.Action.load)
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

extension PreferencesViewController {
    private func setupView() {
    }

    private func setupConstraints() {
    }
}