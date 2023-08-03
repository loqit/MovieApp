import Foundation

class SettingsViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SettingViewModel
    
    private let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func factoryMethod(parser: NetworkPaserProtocol) -> SettingViewModel {
        SettingViewModel(coordinator: coordinator)
    }
}
