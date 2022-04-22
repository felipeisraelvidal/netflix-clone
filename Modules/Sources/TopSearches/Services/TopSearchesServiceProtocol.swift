import Foundation
import Core

public protocol TopSearchesServiceProtocol {
    func getDiscoverTitles(_ completion: @escaping (Result<[Title], Error>) -> Void)
}

#if DEBUG
struct DummyTopSearchesService: TopSearchesServiceProtocol {
    
    func getDiscoverTitles(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        completion(.success([]))
    }
    
}
#endif
