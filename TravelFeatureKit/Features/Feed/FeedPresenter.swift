import UIKit
import TravelKit

typealias FeedPresenter = FeaturePresenter<FeedViewController, FeedAdapter>

class FeedAdapter: FeatureAdapter {
    typealias Content = Feed.Data
    typealias ViewModel = Feed.ViewModel

    func makeViewModel(viewState: ViewState<Feed.ViewModel.Content>) -> Feed.ViewModel {
        return Feed.ViewModel(
            state: viewState,
            title: ""
        )
    }

    func makeContentViewModel(content: Feed.Data) throws -> Feed.ViewModel.Content {
        return Feed.ViewModel.Content()
    }
}
