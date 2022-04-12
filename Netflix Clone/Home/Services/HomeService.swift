import Foundation
import Home
import Core

struct HomeService: HomeServiceProtocol {
    
    func buildSections(_ completion: @escaping ([HomeSection]) -> Void) {
        let sections: [HomeSection] = [
            HomeSection(
                title: "Trending Movies",
                fetchHandler: fetchTrendingMovies(_:)
            ),
            HomeSection(
                title: "Trending TVs",
                fetchHandler: fetchTrendingTVs(_:)
            ),
            HomeSection(
                title: "Popular",
                fetchHandler: fetchPopular(_:)
            ),
            HomeSection(
                title: "Upcoming Movies",
                fetchHandler: fetchUpcomingMovies(_:)
            ),
            HomeSection(
                title: "Top Rated",
                fetchHandler: fetchTopRated(_:)
            )
        ]
        completion(sections)
    }
    
    func fetchHero(_ completion: @escaping (Result<Title?, Error>) -> Void) {
        fetchTopRated { result in
            switch result {
            case .success(let titles):
                let randomTitle = titles.randomElement()
                completion(.success(randomTitle))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func fetchTrendingMovies(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingMovies { result in
            completion(result)
        }
    }
    
    private func fetchTrendingTVs(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingTVs { result in
            completion(result)
        }
    }
    
    private func fetchPopular(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getPopular { result in
            completion(result)
        }
    }
    
    private func fetchUpcomingMovies(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getUpcomingMovies { result in
            completion(result)
        }
    }
    
    private func fetchTopRated(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTopRated { result in
            completion(result)
        }
    }
    
}
