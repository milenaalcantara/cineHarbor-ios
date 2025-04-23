//
//  Trending.swift
//  CineHarbor
//
//  Created by Milena on 23/04/2025.
//

struct TrendingResponse: Decodable {
    let results: [TrendingItem]
}

struct TrendingItem: Decodable {
    let id: Int
    let mediaType: String
    let title: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case title
        case overview
        case posterPath = "poster_path"
        case name // usado por séries
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try? container.decode(String.self, forKey: .posterPath)

        // Ajusta o título dependendo se é filme ou série
        if let movieTitle = try? container.decode(String.self, forKey: .title) {
            title = movieTitle
        } else if let showName = try? container.decode(String.self, forKey: .name) {
            title = showName
        } else {
            title = "Título desconhecido"
        }
    }
}
