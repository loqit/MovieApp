import Foundation

class MovieService: MovieServiceProtocol {
    
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public
    
    func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void) {
        let url = OMDBEndpoint.bySearch(title).url
        networkService.getData(from: url, resultHandler: completion)
    }
    
    func fetchMovieDetails(by id: String, completion: @escaping (Result<MovieDetails, RequestError>) -> Void) {
        let url = OMDBEndpoint.byID(id).url
        networkService.getData(from: url, resultHandler: completion)
    }
}