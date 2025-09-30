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
    let year: String
    let voteAverage: Double
    let posterPath: String?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case title
        case overview
        case posterPath = "poster_path"
        case year = "release_date"
        case firstAirDate = "first_air_date" // usado por séries
        case name // usado por séries
        case voteAverage = "vote_average"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)

        // Ajusta o título dependendo se é filme ou série
        if let movieTitle = try? container.decode(String.self, forKey: .title) {
            title = movieTitle
        } else if let showName = try? container.decode(String.self, forKey: .name) {
            title = showName
        } else {
            title = "Título desconhecido"
        }
        
        if let releaseDate = try? container.decode(String.self, forKey: .year) {
            year = releaseDate
        } else if let firstAirDate = try? container.decode(String.self, forKey: .firstAirDate) {
            year = firstAirDate
        } else {
            year = ""
        }
    }
}
