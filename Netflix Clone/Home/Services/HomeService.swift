import Foundation
import Home
import Core
import Networking

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
        completion(.success(nil))
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
    
    func downloadTitle(_ title: Title, completion: @escaping () -> Void) {
        print("Download title: \(title.safeName)")
        completion()
    }
    
    // MARK: - Private methods
    
    private func fetchTrendingMovies(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let request = HomeTrendingMoviesRequest()
        let client = HTTPClient<TitleResponse>()
        
        client.request(request: request) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "movie")
                
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchTrendingTVs(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let request = HomeTrendingTVsRequest()
        let client = HTTPClient<TitleResponse>()
        
        client.request(request: request) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "tv")
                
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchPopular(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        var error: Error?
        var titles: [Title] = []
        
        let group = DispatchGroup()
        
        let client = HTTPClient<TitleResponse>()
        
        let movieRequest = HomePopularMoviesRequest()
        
        group.enter()
        client.request(request: movieRequest) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "movie")
                
                titles.append(contentsOf: results)
                group.leave()
            case .failure(let err):
                error = err
                group.leave()
            }
        }
        
        let tvRequest = HomePopularTVsRequest()
        
        group.enter()
        client.request(request: tvRequest) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "tv")
                
                titles.append(contentsOf: results)
                group.leave()
            case .failure(let err):
                error = err
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(titles))
            }
        }
    }
    
    private func fetchUpcomingMovies(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let request = HomeUpcomingMoviesRequest()
        let client = HTTPClient<TitleResponse>()
        
        client.request(request: request) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "movie")
                
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchTopRated(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        var error: Error?
        var titles: [Title] = []
        
        let group = DispatchGroup()
        
        let client = HTTPClient<TitleResponse>()
        
        let movieRequest = HomeTopRatedMoviesRequest()
        
        group.enter()
        client.request(request: movieRequest) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "movie")
                
                titles.append(contentsOf: results)
                group.leave()
            case .failure(let err):
                error = err
                group.leave()
            }
        }
        
        let tvRequest = HomeTopRatedTVsRequest()
        
        group.enter()
        client.request(request: tvRequest) { result in
            switch result {
            case .success(let response):
                var results = response.results
                results.mapProperty(\.mediaType, value: "tv")
                
                titles.append(contentsOf: results)
                group.leave()
            case .failure(let err):
                error = err
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(titles))
            }
        }
    }
    
}
