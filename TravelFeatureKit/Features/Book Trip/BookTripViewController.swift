import UIKit
import SnapKit
import RxSwift

class BookTripViewController: UIViewController, FeatureViewController {

    // View Model
    var viewModel: BookTrip.ViewModel?
    var content: BookTrip.ViewModel.Content? { return viewModel?.state.viewModel }
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

    private let headerView = BookTripHeaderView()
    private let bookButton = UIButton()
    private let buttonsView = BookTripButtonsView()
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private let disposeBag = DisposeBag()

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
        guard let content = content else { return }

        headerView.configure(with: content.header)
        bookButton.setTitle(content.bookButton.title, for: .normal)
        buttonsView.configure(with: content.buttons)
        bookButton.isEnabled = !content.isExpired
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
            contentView.style(contentViewStyle).addSubviews(
                headerView.style(headerViewStyle),
                bookButton.style(Style.Button.main).style(bookButtonStyle),
                tableView.style(tableViewStyle),
                buttonsView.style { $0.delegate = self }
            )
        )

        addBlur()
        addDragGestures()

        handleCloseButton()
    }

    private func setupConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(UIScreen.main.bounds.height * 0.8)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(255)
        }

        buttonsView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(16)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }

        bookButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.right.equalTo(self.contentView.snp.right).offset(-16)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.buttonsView.snp.bottom).offset(8)
            make.bottom.equalTo(self.bookButton.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
    }
}

// MARK: - Styles

extension BookTripViewController {
    private func contentViewStyle(_ contentView: UIView) {
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
    }

    private func headerViewStyle(_ headerView: BookTripHeaderView) {
        headerView.backgroundColor = .clear
        headerView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
    }

    private func bookButtonStyle(_ button: UIButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        handleBookButton()
    }

    private func tableViewStyle(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.registerReusableCell(BookTripCell.self)
        tableView.registerReusableHeaderFooterCell(BookTripTableHeaderView.self)
        tableView.estimatedRowHeight = 60
        tableView.estimatedSectionHeaderHeight = 22
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundView = UIView()
        tableView.backgroundView?.backgroundColor = .white
    }
}

// MARK: - Actions

extension BookTripViewController {
    private func handleCloseButton() {
        headerView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

    private func handleBookButton() {
        bookButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let route = self?.content?.bookButton.route else { return }

                self?.router.route(to: route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView

extension BookTripViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return content?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content?.sections[section].rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = content?.sections[indexPath.section].rows[indexPath.row] else {
            return UITableViewCell()
        }

        switch viewModel {
        case .information(let bookTripCellViewModel):
            let cell: BookTripCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.configure(with: bookTripCellViewModel)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = content?.sections[section] else {
            return nil
        }

        let header: BookTripTableHeaderView = tableView.dequeueReusableHeaderFooterView()
        header.configure(with: viewModel.title)
        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension BookTripViewController: BookTripButtonsViewDelegate {
    func onButtonTapped(_ viewModel: BookTripButtonViewModel) {
        interactor.dispatch(viewModel.action)
    }
}
