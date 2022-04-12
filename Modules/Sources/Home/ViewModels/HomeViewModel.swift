import Foundation
import Networking
import Core

extension HomeViewModel {
    enum Section: Int, CaseIterable {
        case trendingMovies = 0
        case trendingTVs = 1
        case popular = 2
        case upcomingMovies = 3
        case topRated = 4
        
        var title: String {
            switch self {
            case .trendingMovies:
                return "Trending Movies"
            case .trendingTVs:
                return "Trending TVs"
            case .popular:
                return "Popular"
            case .upcomingMovies:
                return "Upcoming Movies"
            case .topRated:
                return "Top Rated"
            }
        }
    }
}

public final class HomeViewModel {
    
    let homeService: HomeServiceProtocol
    
    let sections: [Section] = Section.allCases
    private(set) var testSections: [HomeSection] = []
    
    public init(
        homeService: HomeServiceProtocol
    ) {
        self.homeService = homeService
        
        homeService.buildSections { [weak self] sections in
            self?.testSections = sections
        }
    }
    
    public func fetchHeroTitle(_ completion: @escaping (Result<Title?, Error>) -> Void) {
        homeService.fetchHero(completion)
    }
    
}
