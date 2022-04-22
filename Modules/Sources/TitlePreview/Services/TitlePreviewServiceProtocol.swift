import Foundation
import Core

public protocol TitlePreviewServiceProtocol {
    func getTitleDetails(_ titleId: Int, mediaType: String, completion: @escaping (Result<Title, Error>) -> Void)
}

#if DEBUG
struct DummyTitlePreviewService: TitlePreviewServiceProtocol {
    
    func getTitleDetails(_ titleId: Int, mediaType: String, completion: @escaping (Result<Title, Error>) -> Void) {
        let title: Title = .init(
            id: 0,
            mediaType: "movie",
            originalName: "Harry Potter",
            overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        )
        completion(.success(title))
    }
    
}
#endif
