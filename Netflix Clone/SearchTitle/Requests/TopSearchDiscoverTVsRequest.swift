import Foundation
import Networking

struct TopSearchDiscoverTVsRequest: URLRequestProtocol {
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/discover/tv"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants.TMDB.API_KEY,
            "language": Locale.current.identifier,
            "sort_by": "popularity.desc",
            "include_adult": "false",
            "include_video": "false",
            "page": "",
            "with_watch_monetization_types": "flatrate"
        ]
    }
    
}
