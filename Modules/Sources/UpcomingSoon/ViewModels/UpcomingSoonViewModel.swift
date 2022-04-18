import Foundation
import Core

public final class UpcomingSoonViewModel {
    
    private let upcomingSoonService: UpcomingSoonServiceProtocol
    
    private weak var navigation: UpcomingSoonNavigation?
    
    private(set) var titles: [Title] = []
    
    // MARK: - Initializers
    
    public init(
        upcomingSoonService: UpcomingSoonServiceProtocol,
        navigation: UpcomingSoonNavigation
    ) {
        self.upcomingSoonService = upcomingSoonService
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
    
}
