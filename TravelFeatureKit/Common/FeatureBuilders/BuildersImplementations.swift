// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import TravelKit

extension BookTrip {
}

extension BookTrip.Data {
}

extension BookTrip.ViewModel {
    public func with(state: ViewState<BookTrip.ViewModel.Content>) -> BookTrip.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = BookTrip.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }

    public func with(title: String) -> BookTrip.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = BookTrip.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }
}

extension BookTrip.ViewModel.Content {
}

extension Feed {
}

extension Feed.Data {
    public func with(regions: [Region]) -> Feed.Data {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.Data(
            regions: regions,
            trips: trips,
            selectedRegionId: selectedRegionId
        )

        return newInstance
    }

    public func with(trips: [Trip]) -> Feed.Data {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.Data(
            regions: regions,
            trips: trips,
            selectedRegionId: selectedRegionId
        )

        return newInstance
    }

    public func with(selectedRegionId: String) -> Feed.Data {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.Data(
            regions: regions,
            trips: trips,
            selectedRegionId: selectedRegionId
        )

        return newInstance
    }
}

extension Feed.ViewModel {
    public func with(state: ViewState<Feed.ViewModel.Content>) -> Feed.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }

    public func with(title: String) -> Feed.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }
}

extension Feed.ViewModel.Content {
    public func with(rows: [FeedCardViewModel]) -> Feed.ViewModel.Content {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel.Content(
            rows: rows,
            availableRegions: availableRegions,
            selectedRegion: selectedRegion
        )

        return newInstance
    }

    public func with(availableRegions: [Feed.ViewModel.Content.Region]) -> Feed.ViewModel.Content {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel.Content(
            rows: rows,
            availableRegions: availableRegions,
            selectedRegion: selectedRegion
        )

        return newInstance
    }

    public func with(selectedRegion: Feed.ViewModel.Content.Region) -> Feed.ViewModel.Content {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel.Content(
            rows: rows,
            availableRegions: availableRegions,
            selectedRegion: selectedRegion
        )

        return newInstance
    }
}

extension Feed.ViewModel.Content.Region {
    public func with(id: String) -> Feed.ViewModel.Content.Region {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel.Content.Region(
            id: id,
            name: name
        )

        return newInstance
    }

    public func with(name: String) -> Feed.ViewModel.Content.Region {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Feed.ViewModel.Content.Region(
            id: id,
            name: name
        )

        return newInstance
    }
}

extension FeedCardViewModel {
    public func with(direction: String) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(trip: String) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(price: String) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(dateRange: String) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(routeName: String) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(imageUrl: URL) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(route: Feed.Route) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }

    public func with(isExpired: Bool) -> FeedCardViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = FeedCardViewModel(
            direction: direction,
            trip: trip,
            price: price,
            dateRange: dateRange,
            routeName: routeName,
            imageUrl: imageUrl,
            route: route,
            isExpired: isExpired
        )

        return newInstance
    }
}

extension Preferences {
}

extension Preferences.Data {
}

extension Preferences.ViewModel {
    public func with(state: ViewState<Preferences.ViewModel.Content>) -> Preferences.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Preferences.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }

    public func with(title: String) -> Preferences.ViewModel {
        // Note: The order of the properties have to match the order
        // of the paramaters in the init method
        let newInstance = Preferences.ViewModel(
            state: state,
            title: title
        )

        return newInstance
    }
}

extension Preferences.ViewModel.Content {
}
