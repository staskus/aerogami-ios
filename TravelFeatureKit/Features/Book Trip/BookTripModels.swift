import Foundation
import TravelKit

struct BookTrip {
    struct Data: Equatable {
        let trip: Trip
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<BookTrip.ViewModel.Content>
        let title: String

        struct Content: FeatureContentViewModel {
            let header: BookTripHeaderViewModel
            let sectionButtons: [BookTrip.ViewModel.SectionButton]
            let bookButton: BookTrip.ViewModel.BookButton
        }

        struct SectionButton {
            let title: String
            let image: String
            let action: BookTrip.Action
        }

        struct BookButton {
            let title: String
            let route: BookTrip.Route
        }
    }

    enum Action {
        case load
        case favorite
        case share
    }

    enum Route {
        case book
    }
}
