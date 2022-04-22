import Foundation
import Networking

struct SearchMoviesResultRequest: URLRequestProtocol {
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/search/movie"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return [
            "api_key": Constants.TMDB.API_KEY,
            "query": query
        ]
    }
    
}
