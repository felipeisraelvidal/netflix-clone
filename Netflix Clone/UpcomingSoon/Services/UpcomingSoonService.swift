import Foundation
import UpcomingSoon
import Core

struct UpcomingSoonService: UpcomingSoonServiceProtocol {
    
    func fetchUpcomingTitles(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getUpcomingMovies { result in
            completion(result)
        }
    }
    
}
