import Foundation
import Core

public final class UpcomingSoonViewModel {
    
    private let upcomingSoonService: UpcomingSoonServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    private weak var navigation: UpcomingSoonNavigation?
    
    private(set) var titles: [Title] = []
    
    // MARK: - Initializers
    
    public init(
        upcomingSoonService: UpcomingSoonServiceProtocol,
        imageRequest: ImageRequestProtocol,
        navigation: UpcomingSoonNavigation
    ) {
        self.upcomingSoonService = upcomingSoonService
        self.imageRequest = imageRequest
        self.navigation = navigation
    }
    
    // MARK: - Public methods
    
    public func fetchTitles(_ completion: @escaping (Error?) -> Void) {
        upcomingSoonService.fetchUpcomingTitles { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    public func goToTitleDetails(title: Title) {
        navigation?.goToTitleDetails(title)
    }
    
    public func goToTitlePlayer(title: Title) {
        navigation?.goToPlayTitle(title)
    }
    
}
