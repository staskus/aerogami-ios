import UIKit
import RxSwift
import TravelKit

class FeedInteractor {
    private let presenter: FeedPresenter
    private var disposeBag = DisposeBag()
    
    private let regionRepository: RegionRepository

    private var contentState: ContentState<Feed.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(presenter: FeedPresenter, regionRepository: RegionRepository) {
        self.presenter = presenter
        self.regionRepository = regionRepository
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
        
        regionRepository.getRegions()
            .map {
                Feed.Data(
                    regions: $0,
                    selectedRegionId: nil
                )
            }
            .subscribe(
                onNext: { data in
                    self.contentState = .loaded(data: data, error: nil)
                },
                onError: { error in
                    self.contentState = .error(error: .loading(reason: error.localizedDescription))
                }
            )
            .disposed(by: disposeBag)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
