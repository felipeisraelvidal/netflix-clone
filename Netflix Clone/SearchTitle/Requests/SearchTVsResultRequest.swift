import Foundation
import Networking

struct SearchTVsResultRequest: URLRequestProtocol {
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    var baseURL: String {
        return Constants2.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/search/tv"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants2.TMDB.API_KEY,
            "query": query
        ]
    }
    
}
