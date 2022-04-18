import Foundation
import Networking

struct HomePopularTVsRequest: URLRequestProtocol {
    
    var baseURL: String {
        return Constants2.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/tv/popular"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants2.TMDB.API_KEY,
            "language": Locale.current.identifier,
            "page": "1"
        ]
    }
    
}
