import Foundation
import Core

public final class SearchResultsViewModel {
    
    private let searchResultsService: SearchResultsServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    private(set) var titles: [Title] = []
    
    // MARK: - Initializers
    
    public init(
        searchResultsService: SearchResultsServiceProtocol,
        imageRequest: ImageRequestProtocol
    ) {
        self.searchResultsService = searchResultsService
        self.imageRequest = imageRequest
    }
    
    // MARK: - Public methods
    
    func searchMovies(with searchText: String, completion: @escaping (Error?) -> Void) {
        searchResultsService.getMovies(with: searchText) { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}
