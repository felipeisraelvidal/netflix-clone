import Foundation

public struct Title: Codable {
    public let id: Int
    public var mediaType: String?
    public let originalName: String?
    public let originalTitle: String?
    public let posterPath: String?
    public let overview: String?
    public let voteCount: Int
    public let releaseDate: String?
    public let voteAverage: Double
    public let backdropPath: String?
    public let popularity: Double?
    
    public var safeName: String {
        originalTitle ?? originalName ?? "Unknown name"
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
        case popularity = "popularity"
    }
    
    public init(
        id: Int,
        mediaType: String? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        originalName: String? = nil,
        overview: String? = nil
    ) {
        self.id = id
        self.mediaType = mediaType
        self.originalName = originalName
        self.originalTitle = nil
        self.posterPath = posterPath
        self.overview = overview
        self.voteCount = 0
        self.releaseDate = nil
        self.voteAverage = 0
        self.backdropPath = backdropPath
        self.popularity = nil
    }
}
