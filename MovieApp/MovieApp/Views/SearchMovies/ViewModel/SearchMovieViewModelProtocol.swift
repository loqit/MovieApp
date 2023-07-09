import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {

    var onDataLoaded: (() -> Void)? { get set }
    var onLoading: ((Bool) -> Void)? { get set }
    
    func fetchMovies(by title: String)
}
