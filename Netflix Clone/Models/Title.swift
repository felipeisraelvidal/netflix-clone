//
//  Title.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 27/12/21.
//

import Foundation
import Core

struct TitleResponse: Codable {
    let results: [Title]
}

struct Title1: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
    let backdropPath: String?
    
    var safeName: String {
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
    }
}
