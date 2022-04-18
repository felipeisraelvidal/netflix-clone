import Foundation

public protocol URLRequestProtocol {
    /// The API's base url
    var baseURL: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String : String]? { get }
}

extension URLRequestProtocol {
    
    var parameters: [String : Any]? {
        return nil
    }
    
}
