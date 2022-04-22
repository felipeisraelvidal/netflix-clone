import Foundation
import Core

public protocol SearchResultsServiceProtocol {
    func getMovies(with searchText: String, completion: @escaping (Result<[Title], Error>) -> Void)
}

#if DEBUG
struct DummySearchResultsService: SearchResultsServiceProtocol {
    
    func getMovies(with searchText: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
}
#endif
