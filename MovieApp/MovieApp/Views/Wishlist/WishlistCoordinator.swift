import Foundation
import UIKit

class WishlistCoordinator: Coordinator {
  
  // MARK: Properties
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModelFabric = WishlistViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    print("♦️WishlistViewModel start() viewModel:", viewModel)
    
    let viewController = WishListViewController(viewModel: viewModel)
    
    navigationController.pushViewController(viewController, animated: false)
  }
}
