import Foundation
import DownloadedTitles
import Core

struct DownloadedTitlesService: DownloadedTitlesServiceProtocol {
    
    func fetchDownloadedTitles(_ completion: (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
}
