import Foundation
import TravelKit

struct Feed {
    struct Data: Equatable {
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<Feed.ViewModel.Content>
        let title: String

        struct Content: FeatureContentViewModel {
        }
    }

    enum Action {
        case load
    }

    enum Route {
    }
}
