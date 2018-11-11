import Foundation
import TravelKit

struct BookTrip {
    struct Data: Equatable {
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<BookTrip.ViewModel.Content>
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
