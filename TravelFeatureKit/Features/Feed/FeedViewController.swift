import UIKit
import SnapKit

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

    private let tableView = UITableView()

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
        tableView.reloadData()
    }

    // MARK: - Required Init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedViewController {
    private func setupView() {
        view.addSubviews(
            tableView.style(tableViewStyle)
        )
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.margins)
        }
    }
}

extension FeedViewController {
    private func tableViewStyle(_ tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerReusableCell(FeedCardCell.self)
        tableView.delaysContentTouches = false
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel?.state.viewModel else { return 0 }

        return viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.state.viewModel?.rows[indexPath.row] else { return UITableViewCell() }

        let cell: FeedCardCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
