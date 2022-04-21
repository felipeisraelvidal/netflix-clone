import Foundation
import Home
import Core
import Networking

struct HeroService: HeroServiceProtocol {
    
    func fetchHeroTitles(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        var error: Error?
        var titles: [Title] = []
        
        let group = DispatchGroup()
        
        let client = HTTPClient<TitleResponse>()
        
        let movieRequest = HomeTrendingMoviesRequest()
        
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
        
        let tvRequest = HomeTrendingTVsRequest()
        
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
                titles.sort(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) })
                let arraySlice = Array(titles.prefix(5))
                
                completion(.success(arraySlice))
            }
        }
    }
    
}
