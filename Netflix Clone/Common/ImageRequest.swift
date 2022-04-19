import Foundation
import Core

struct ImageRequest: ImageRequestProtocol {
    
    var baseURL: String {
        Constants2.TMDB.IMAGE_BASE_URL
    }
    
}
