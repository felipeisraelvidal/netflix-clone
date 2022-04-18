import Foundation

public struct TitleResponse: Codable {
    public let results: [Title]
}

public struct Title: Codable {
    private let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    public let id: Int
    public let mediaType: String?
    public let originalName: String?
    public let originalTitle: String?
    public let posterPath: String?
    public let overview: String?
    public let voteCount: Int
    public let releaseDate: String?
    public let voteAverage: Double
    public let backdropPath: String?
    
    public var safeName: String {
        originalTitle ?? originalName ?? "Unknown name"
    }
    
    public var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "\(baseImageURL)\(posterPath)")
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
    
    public init(
        id: Int,
        mediaType: String? = nil,
        backdropPath: String? = nil,
        originalName: String? = nil,
        overview: String? = nil
    ) {
        self.id = id
        self.mediaType = mediaType
        self.originalName = originalName
        self.originalTitle = nil
        self.posterPath = nil
        self.overview = overview
        self.voteCount = 0
        self.releaseDate = nil
        self.voteAverage = 0
        self.backdropPath = backdropPath
    }
}
