//
//  YouTubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 09/01/22.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [YouTubeSearchResponse.Item]
}

extension YouTubeSearchResponse {
    struct Item: Codable {
        let id: Id
    }
}

extension YouTubeSearchResponse.Item {
    struct Id: Codable {
        let kind: String
        let videoId: String?
    }
}
