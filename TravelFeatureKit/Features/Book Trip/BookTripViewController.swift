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

    // UI

    let contentView = UIView()
    let blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let blurHeader = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

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

        showBlur()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.unsubscribe()

        hideBlur()
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
        view.backgroundColor = .clear

        view.addSubviews(
            blurHeader,
            contentView.style(contentViewStyle)
        )

        addBlur()
        addDragGestures()
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(UIScreen.main.bounds.height * 0.85)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

// MARK: - Styles

extension BookTripViewController {
    private func contentViewStyle(_ contentView: UIView) {
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        contentView.backgroundColor = .white
    }
}
