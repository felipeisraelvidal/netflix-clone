import Foundation
import Core

struct ImageRequest: ImageRequestProtocol {
    
    var baseURL: String {
        Constants.TMDB.IMAGE_BASE_URL
    }
    
}
