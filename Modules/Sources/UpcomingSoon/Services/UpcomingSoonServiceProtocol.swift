import Foundation
import Core

public protocol UpcomingSoonServiceProtocol {
    func fetchUpcomingTitles(_ completion: @escaping (Result<[Title], Error>) -> Void)
}

#if DEBUG
struct DummyUpcomingSoonService: UpcomingSoonServiceProtocol {
    
    func fetchUpcomingTitles(_ completion: @escaping (Result<[Title], Error>) -> Void) {
        let titles: [Title] = [
            .init(
                id: 0,
                backdropPath: "https://images4.alphacoders.com/676/thumb-1920-676894.jpg",
                originalName: "Harry Potter and the Philosopher's Stone",
                overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            ),
            .init(
                id: 1,
                backdropPath: "https://wallpaperaccess.com/full/4226887.jpg",
                originalName: "Harry Potter and the Chamber of Secrets"
            )
        ]
        completion(.success(titles))
    }
    
}
#endif
