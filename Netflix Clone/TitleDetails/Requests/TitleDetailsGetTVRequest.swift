import Foundation
import Networking

struct TitleDetailsGetTVRequest: URLRequestProtocol {
    
    private let tvID: Int
    
    init(tvID: Int) {
        self.tvID = tvID
    }
    
    var baseURL: String {
        return Constants.TMDB.BASE_URL
    }
    
    var path: String? {
        return "/3/tv/\(tvID)"
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
