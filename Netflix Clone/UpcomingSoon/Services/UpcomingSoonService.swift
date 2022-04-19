import Foundation
import UpcomingSoon
import Core
import Networking

struct UpcomingSoonService: UpcomingSoonServiceProtocol {
    
    func fetchUpcomingTitles(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let request = UpcomingSoonRequest()
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
    
}
