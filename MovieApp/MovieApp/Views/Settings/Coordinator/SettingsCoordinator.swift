import UIKit

class SettingsCoordinator: SettingsCoordinatorProtocol {

    // MARK: - Properties
    
    var navigationController: UINavigationController
    var dependecyManager: DependencyManager
    private var viewModel: SettingsViewModelProtocol {
        let viewModelCreator = SettingsViewModelCreator(coordinator: self)
        let viewModel = viewModelCreator.factoryMethod()
        return viewModel
    }
    
    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }
    
    // MARK: - Public
    
    func start() {
        let viewController = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - SettingsCoordinatorProtocol
    
    func openLanguages() {
        let viewController = SettingsLanguagesViewController()
        viewController.data = .init(languages: viewModel.languages,
                                    currentLanguage: viewModel.currentLanguage ?? .english)
        viewController.actions = .init(select: { language, completion in
            Bundle.setLanguage(lang: language.rawValue)
            completion(.success(()))
        })
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openApperance() {
        let viewController = ApperanceViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAccount() {
        let authService = AuthService()
        if let _ = authService.currentUser {
            let profileCoordinator = EditProfileCoordinator(navigationController: navigationController, dependecyManager: dependecyManager)
            profileCoordinator.start()
        } else {
            let authCoordinator = AuthCoordinator(navigationController: navigationController, dependecyManager: dependecyManager)
            authCoordinator.start()
        }
    }
}
