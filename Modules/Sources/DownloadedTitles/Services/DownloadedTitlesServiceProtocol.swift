import Foundation
import Core

public protocol DownloadedTitlesServiceProtocol {
    func fetchDownloadedTitles(_ completion: (Result<[Title], Error>) -> Void)
}

#if DEBUG
struct DummyDownloadedTitleService: DownloadedTitlesServiceProtocol {
    
    func fetchDownloadedTitles(_ completion: (Result<[Title], Error>) -> Void) {
        let titles: [Title] = [
            .init(
                id: 0,
                backdropPath: "/hziiv14OpD73u9gAak4XDDfBKa2.jpg",
                originalName: "Harry Potter and the Philosopher's Stone",
                overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            ),
            .init(
                id: 1,
                backdropPath: "/zZhXaiJndrF6hoAnhUMJ5J0Y3hq.jpg",
                originalName: "Harry Potter and the Chamber of Secrets"
            )
        ]
        
        completion(.success(titles))
    }
    
}
#endif
