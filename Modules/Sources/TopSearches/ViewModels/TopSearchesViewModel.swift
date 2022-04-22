import Foundation
import Core

public final class TopSearchesViewModel {
    
    private let topSearchesService: TopSearchesServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    weak var navigation: TopSearchesNavigation!
    
    private(set) var titles: [Title] = []
    
    // MARK: - Initializers
    
    public init(
        topSearchesService: TopSearchesServiceProtocol,
        imageRequest: ImageRequestProtocol,
        navigation: TopSearchesNavigation
    ) {
        self.topSearchesService = topSearchesService
        self.imageRequest = imageRequest
        self.navigation = navigation
    }
    
    // MARK: - Public methods
    
    func fetchDiscoverTitles(_ completion: @escaping (Error?) -> Void) {
        topSearchesService.getDiscoverTitles { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // MARK: - Private methods
    
    public func goToTitleDetails(title: Title) {
        navigation?.goToTitleDetails(title)
    }
    
    public func goToTitlePlayer(title: Title) {
        navigation?.goToPlayTitle(title)
    }
    
}
