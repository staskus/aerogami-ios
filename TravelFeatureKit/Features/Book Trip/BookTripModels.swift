import Foundation
import TravelKit

struct BookTrip {
    struct Data: Equatable {
        let trip: Trip
        let bookUrl: URL
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<BookTrip.ViewModel.Content>
        let title: String

        struct Content: FeatureContentViewModel {
            let header: BookTripHeaderViewModel
            let sectionButtons: [BookTrip.ViewModel.SectionButton]
            let bookButton: BookTrip.ViewModel.BookButton
            let sections: [BookTrip.ViewModel.Section]
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
        
        struct Section {
            let rows: [BookTrip.ViewModel.Row]
        }
        
        enum Row {
            case information(BookTripCellViewModel)
        }
    }

    enum Action {
        case load
        case favorite
        case share
    }

    enum Route {
        case book(URL)
    }
}
