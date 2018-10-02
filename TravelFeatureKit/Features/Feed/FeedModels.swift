import Foundation
import TravelKit

struct Feed {
    struct Data: Equatable {
        let regions: [Region]
        let trips: [Trip]
        let selectedRegionId: String?
    }

    struct ViewModel: FeatureViewModel {
        let state: ViewState<Feed.ViewModel.Content>
        let title: String

        struct Content: FeatureContentViewModel {
            var rows: [FeedCardViewModel]
            let availableRegions: [Feed.ViewModel.Content.Region]
            let selectedRegion: Feed.ViewModel.Content.Region?

            struct Region: Equatable {
                let id: String
                let name: String
            }
        }
    }

    enum Action {
        case load
        case changeRegion(regionId: String?)
    }

    enum Route {
        case book
    }
}
