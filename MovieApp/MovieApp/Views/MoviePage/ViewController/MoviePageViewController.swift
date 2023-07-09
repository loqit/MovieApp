import UIKit

class MoviePageViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    private var viewModel: MoviePageViewModelProtocol?
    var spinner: SpinnerViewController = SpinnerViewController()
    var movieID: String?
    
    @IBOutlet private weak var moviePoster: UIImageView?
    @IBOutlet private weak var movieTitle: UILabel?
    @IBOutlet private weak var movieDescription: UILabel?
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    convenience init(viewModel: MoviePageViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    // MARK: - @IBAction
    
    @IBAction func saveMovie(_ sender: UIButton) {
        viewModel?.saveCurrentMovie()
    }
    
    @IBAction func deleteMovie(_ sender: UIButton) {
        viewModel?.deleteCurrentMovie()
    }
    
    // MARK: - Public
    
    func loadData() {
        showSpinner()
        viewModel?.onDataLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let data = self?.viewModel?.movieDetails else {
                    return
                }
                
                self?.moviePoster?.load(from: data.poster)
                self?.movieTitle?.text = data.title
                self?.movieDescription?.text = data.plot
                
                self?.view.layoutIfNeeded()
                self?.hideSpinner()
            }
        }
        viewModel?.fetchMovieDetails(by: self.movieID ?? "")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .tabBarTintColor
        navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        movieDescription?.sizeToFit()
        movieDescription?.baselineAdjustment = .alignCenters
        
        saveButton.tintColor = traitCollection.userInterfaceStyle == .light ? Constants.SaveButton.lightThemeColor: Constants.SaveButton.darkThemeColor
        deleteButton.tintColor = .deleteButtonColor
    }
}
