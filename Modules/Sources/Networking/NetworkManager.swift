import Foundation
import Combine
import Core

struct Constants {
    static let API_KEY = "12bb12378f504a44501ed07fff277c21"
    static let YOUTUBE_API_KEY = "AIzaSyBuDyvWfuqfDE3qdF92_6cv8970rqyWHNg"
}

public final class NetworkManager {
    public static let shared = NetworkManager()
    
    private let baseURL = "https://api.themoviedb.org"
    private let youtubeBaseURL = "https://www.googleapis.com/youtube/v3"
    
    private var anyCancellable = Set<AnyCancellable>()
    
    private func request<T: Codable>(url: URL, type: T.Type) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
        
        return Future { [unowned self] promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .retry(1)
                .mapError({ $0 })
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    
                    return element.data
                }
                .decode(type: type, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { result in
                    promise(.success(result))
                }
                .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
    
    public func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func getTrendingTVs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request<T: Decodable>(of type: T.Type = T.self, url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(type, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    public func getTitleDetails(_ title: Title, completion: @escaping (Result<Title, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/3/movie/\(title.id)?api_key=\(Constants.API_KEY)&language=en-US") else { return }
        
        
    }
    
}
