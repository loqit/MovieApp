import Foundation
import UIKit

class SearchMovieCoordinator: Coordinator {

  // MARK: Properties
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: Public

  func start() {
    let viewModelFabric = SearchMovieViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    print("♦️SearchMovieCoordinator start() viewModel:", viewModel)
    
    let viewController = SearchMoviesViewController(viewModel: viewModel)
    viewController.actions = .init(openMovie: openMovie)
    
    navigationController.pushViewController(viewController, animated: false)
  }

  // MARK: Private
  
  private func openMovie(_ movieID: String) {
    print("MovieID \(movieID)")
    let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
    moviePageCoordinator.start()
  }
}
