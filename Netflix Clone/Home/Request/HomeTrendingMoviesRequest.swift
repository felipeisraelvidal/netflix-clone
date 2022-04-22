import Foundation
import Networking

struct HomeTrendingMoviesRequest: URLRequestProtocol {
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/trending/movie/day"
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
