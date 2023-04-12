import UIKit

class WishListViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet private weak var tableView: UITableView!
  private var viewModel: WishlistViewModelProtocol?
  
  convenience init(viewModel: WishlistViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)
    print("♦️WishlistViewModelProtocol init viewModel:", viewModel)
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.delegate = self
    setUpTableView()
    loadWishlist()
  }
  
  private func loadWishlist() {
    viewModel?.onDataLoaded = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    viewModel?.loadWishlist()
  }
  
  private func setUpTableView() {
    guard let tableView = tableView else { return }
    view.addSubview(tableView)
    tableView.backgroundColor = Constants.Colors.clear
    tableView.rowHeight = Constants.Sizes.tableViewRowStandart
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
  }
}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel?.getMovies().count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = self.viewModel?.movie(at: indexPath.row)
    cell.setUp(from: movie)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 //   let movie = viewModel?.movie(at: indexPath.row)
 //   self.actions?.openMovie(movie?.imdbID ?? "")
  }
}

extension WishListViewController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    DispatchQueue.main.async {
      self.loadWishlist()
    }
  }
}
