import Foundation
import Networking

struct TitleDetailsGetMovieRequest: URLRequestProtocol {
    
    private let movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/movie/\(movieID)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants.TMDB.API_KEY
        ]
    }
    
}
