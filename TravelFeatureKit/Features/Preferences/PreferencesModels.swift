import Foundation
import TravelKit

struct Preferences {
    struct Data: Equatable {
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<Preferences.ViewModel.Content>
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
