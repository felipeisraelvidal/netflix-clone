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
    
    let sections: [Section] = Section.allCases
    
    public init() {}
    
    public func fetchTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        NetworkManager.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                completion(.success(titles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchTrendingTVs(completion: @escaping (Result<[Title], Error>) -> Void) {
        NetworkManager.shared.getTrendingTVs { result in
            switch result {
            case .success(let titles):
                completion(.success(titles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        NetworkManager.shared.getPopular { result in
            switch result {
            case .success(let titles):
                completion(.success(titles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        NetworkManager.shared.getUpcomingMovies { result in
            switch result {
            case .success(let titles):
                completion(.success(titles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        NetworkManager.shared.getTopRated { result in
            switch result {
            case .success(let titles):
                completion(.success(titles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchHeroTitle(_ completion: @escaping (Result<Title?, Error>) -> Void) {
        fetchTopRatedMovies { result in
            switch result {
            case .success(let titles):
                let randomTitle = titles.randomElement()
                completion(.success(randomTitle))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
