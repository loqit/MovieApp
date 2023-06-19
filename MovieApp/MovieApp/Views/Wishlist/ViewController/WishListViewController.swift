import UIKit

class WishListViewController: UIViewController, RefreshableViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var tableView: UITableView!
  private var dataSource: MoiveListDatsSource?
  private var delegate: MovieListDelegate?
  
  private var viewModel: WishlistViewModelProtocol?
  var spinner: SpinnerViewController = SpinnerViewController()
  
  struct Actions {

    var openMovie: (_ movieID: String) -> Void
  }
  
  var actions: Actions?
  
  convenience init(viewModel: WishlistViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)

    self.viewModel = viewModel
    dataSource = MoiveListDatsSource(viewModel: viewModel)
    delegate = MovieListDelegate(viewModel: viewModel)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tabBarController?.delegate = self
    setupTableView()
    loadWishlist()
  }
  
  // MARK: - Private
  
  private func setupTableView() {    
    actions.do { actions in
      delegate?.actions = .init(openMovie: actions.openMovie)
    }
    
    MovieListStyle.baseMovieListStyle(tableView)
    tableView.dataSource = dataSource
    tableView.delegate = delegate
  }

  private func loadWishlist() {
    showSpinner()
    viewModel?.onDataLoaded = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
        self?.hideSpinner()
      }
    }
    viewModel?.loadWishlist()
  }
}

extension WishListViewController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    DispatchQueue.main.async {
      self.loadWishlist()
    }
  }
}
