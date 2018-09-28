import UIKit
import TravelKit

typealias PreferencesPresenter = FeaturePresenter<PreferencesViewController, PreferencesAdapter>

class PreferencesAdapter: FeatureAdapter {
    typealias Content = Preferences.Data
    typealias ViewModel = Preferences.ViewModel

    func makeViewModel(viewState: ViewState<Preferences.ViewModel.Content>) -> Preferences.ViewModel {
        return Preferences.ViewModel(
            state: viewState,
            title: ""
        )
    }

    func makeContentViewModel(content: Preferences.Data) throws -> Preferences.ViewModel.Content {
        return Preferences.ViewModel.Content()
    }
}
