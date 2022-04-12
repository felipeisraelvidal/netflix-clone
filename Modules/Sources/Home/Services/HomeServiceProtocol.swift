import Foundation
import Core

public struct HomeSection {
    var title: String
    var fetchHandler: (@escaping (Result<[Title], Error>) -> Void) -> Void
    
    public init(
        title: String,
        fetchHandler: @escaping (@escaping (Result<[Title], Error>) -> Void) -> Void
    ) {
        self.title = title
        self.fetchHandler = fetchHandler
    }
}

public protocol HomeServiceProtocol {
    func buildSections(_ completion: @escaping ([HomeSection]) -> Void)
    func fetchHero(_ completion: @escaping (Result<Title?, Error>) -> Void)
}

#if DEBUG
struct DummyHomeService: HomeServiceProtocol {
    
    // MARK: - Public methods
    
    func buildSections(_ completion: @escaping ([HomeSection]) -> Void) {
        completion([
            HomeSection(
                title: "Trending Movies",
                fetchHandler: fetchTrendingMovies(_:)
            ),
            HomeSection(
                title: "Trending TVs",
                fetchHandler: fetchTrendingMovies(_:)
            ),
            HomeSection(
                title: "Popular",
                fetchHandler: fetchPopular(_:)
            )
        ])
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
    
    func fetchTrendingMovies(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let titles: [Title] = [
            Title(
                id: 0,
                originalName: "Title 1"
            ),
            Title(
                id: 1,
                originalName: "Title 2"
            ),
            Title(
                id: 2,
                originalName: "Title 3"
            ),
            Title(
                id: 3,
                originalName: "Title 4"
            ),
            Title(
                id: 4,
                originalName: "Title 5"
            )
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            completion(.success(titles))
        }
    }
    
    func fetchTrendingTVs(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
    func fetchPopular(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
    func fetchTopRated(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
}
#endif
