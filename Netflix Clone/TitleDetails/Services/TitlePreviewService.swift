import Foundation
import TitlePreview
import Core
import Networking

enum TitlePreviewServiceError: Error {
    case invalidMediaType
}

struct TitlePreviewService: TitlePreviewServiceProtocol {
    
    func getTitleDetails(_ titleId: Int, mediaType: String, completion: @escaping (Result<Title, Error>) -> Void) {
        var request: URLRequestProtocol?
        let client = HTTPClient<Title>()
        
        switch mediaType {
        case "movie":
            request = TitleDetailsGetMovieRequest(movieID: titleId)
            client.request(request: request!) { result in
                switch result {
                case .success(var title):
                    title.mediaType = mediaType
                    completion(.success(title))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case "tv":
            request = TitleDetailsGetTVRequest(tvID: titleId)
            client.request(request: request!) { result in
                switch result {
                case .success(var title):
                    title.mediaType = mediaType
                    completion(.success(title))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        default:
            completion(.failure(TitlePreviewServiceError.invalidMediaType))
        }
    }
    
}
