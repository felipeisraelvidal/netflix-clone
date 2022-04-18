import Foundation

public final class HTTPClient<T: Decodable> {
    
    public init() {}
    
    public func request(of type: T.Type = T.self, request: URLRequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        if var baseURL = URLComponents(string: request.baseURL) {
            if let path = request.path {
                baseURL.path = path
            }
            
            if let parameters = request.parameters {
                print(parameters)
                baseURL.queryItems = parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
            }
            
            guard let url = baseURL.url else { return }
            
            var requestURL = URLRequest(url: url)
            requestURL.httpMethod = request.method.name
            
            let dataTask = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                switch httpResponse.statusCode {
                case 200:
                    do {
                        guard let data = data else { return }
                        
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(type, from: data)
                        
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(error))
                    }
                case 304:
                    completion(.failure(HTTPError.notModified))
                case 422:
                    completion(.failure(HTTPError.unprocessableEntity))
                case 503:
                    completion(.failure(HTTPError.serviceUnavailable))
                default:
                    break
                }
            }
            
            dataTask.resume()
        }
    }
    
}