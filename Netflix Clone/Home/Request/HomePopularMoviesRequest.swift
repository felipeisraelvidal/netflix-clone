import Foundation
import Networking

struct HomePopularMoviesRequest: URLRequestProtocol {
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/movie/popular"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants.TMDB.API_KEY,
            "language": Locale.current.identifier,
            "page": "1"
        ]
    }
    
}
