import UIKit

class AppCoordinatior: CoordinatorProtocol {

    // MARK: - Private Propertis
    
    private let window: UIWindow
    private var tag = 0
    
    // MARK: - Public Properties
    
    var navigationController: UINavigationController = UINavigationController()
    var dependecyManager: DependencyManager
    
    init(window: UIWindow, dependecyManager: DependencyManager) {
        self.window = window
        self.dependecyManager = dependecyManager
    }
    
    // MARK: - Public
    
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Constants.TabBar.color
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        // TODO: Remove navigation controllers for this coordinators
        let searchMovieCoordinator = SearchMovieCoordinator(navigationController: UINavigationController(), dependecyManager: dependecyManager)
        let wishlistCoordinator = WishlistCoordinator(navigationController: UINavigationController(), dependecyManager: dependecyManager)
        let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController(), dependecyManager: dependecyManager)
        let chatCoordinator = ChatListCooridnator(navigationController: UINavigationController(), dependecyManager: dependecyManager)
        
        let searchVC = setupViewController(coordinator: searchMovieCoordinator,
                                           title: "Search".localized(),
                                           image: Constants.TabBar.searchImage)
        let wishlistVC = setupViewController(coordinator: wishlistCoordinator,
                                             title: "Wishlist".localized(),
                                             image: Constants.TabBar.wishlistImage)
        let settingsVC = setupViewController(coordinator: settingsCoordinator,
                                             title: "Settings".localized(),
                                             image: Constants.TabBar.settingsImage)
        let chatVC = setupViewController(coordinator: chatCoordinator,
                                         title: "Chats",
                                         image: Constants.TabBar.messageImage)

        let viewControllers = [searchVC, wishlistVC, settingsVC, chatVC]
        tabBarController.viewControllers = viewControllers
        
        coordinate(to: searchMovieCoordinator)
        coordinate(to: wishlistCoordinator)
        coordinate(to: settingsCoordinator)
        coordinate(to: chatCoordinator)
    }
    
    // MARK: - Private
    
    private func generateTag() -> Int {
        tag += 1
        return tag
    }
    
    private func setupViewController(coordinator: CoordinatorProtocol, title: String, image: UIImage?) -> UIViewController {
        let viewController = coordinator.navigationController
        let localizedTitle = NSLocalizedString(title, comment: "")
        let tabBarItem = UITabBarItem(title: localizedTitle, image: image, tag: generateTag())
        viewController.tabBarItem = tabBarItem
        return viewController
    }
}
