import UIKit
import RxSwift
import TravelKit

class FeedInteractor {
    private let presenter: FeedPresenter
    private var disposeBag = DisposeBag()

    private var contentState: ContentState<Feed.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }

    func dispatch(_ action: Feed.Action) {
        switch action {
        case .load:
            loadData()
        }
    }

    private func loadData() {
        disposeBag = DisposeBag()

        contentState = .loading(data: contentState.data)
    }

    public func subscribe() {
        presenter.present(contentState)
    }

    public func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
