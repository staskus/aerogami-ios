import UIKit
import RxSwift
import TravelKit

class PreferencesInteractor {
    private let presenter: PreferencesPresenter
    private var disposeBag = DisposeBag()

    private var contentState: ContentState<Preferences.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(presenter: PreferencesPresenter) {
        self.presenter = presenter
    }

    func dispatch(_ action: Preferences.Action) {
        switch action {
        case .load:
            loadData()
        }
    }

    private func loadData() {
        disposeBag = DisposeBag()

        contentState = .loading(data: contentState.data)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
