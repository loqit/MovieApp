import Foundation
import Combine

class WishlistViewModel: MovieViewModelProtocol, WishlistViewModelProtocol {
    
    // MARK: - Properties

    @Published private var isDataLoaded = false
    @Published private var isLoading = false
    
    var isDataLoadedPublisher: Published<Bool>.Publisher { $isDataLoaded }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    private let coordinator: WishlistCoordinatorProtocol
    private var dataService: RealmServiceProtocol
    private(set) var moviesDB: [RealmMovie] = []
    var moviesCount: Int {
        moviesDB.count
    }
    
    init(dataService: RealmServiceProtocol, coordinator: WishlistCoordinatorProtocol) {
        self.dataService = dataService
        self.coordinator = coordinator
    }
    
    // MARK: - Public
    
    func loadWishlist() {
        isLoading = true
        isDataLoaded = false
        dataService.getAllObjects(ofType: RealmMovie.self) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let data):
                self?.moviesDB = data
                self?.isDataLoaded = true
            case .failure(let error):
                print("Something went wrong: \(error)")
            }
        }
    }
    
    func deleteMovie(by id: String) {
        dataService.deleteObject(ofType: RealmMovie.self) { $0.imdbID == id }
    }
    
    func movie(at index: Int) -> MovieModelProtocol {
        moviesDB[index]
    }
    
    func remove(at index: Int) {
        let id = moviesDB[index].imdbID
        deleteMovie(by: id)
        moviesDB.remove(at: index)
    }
    
    func openMovie(_ movieID: String) {
        coordinator.navigateToMovie(movieID)
    }
}
