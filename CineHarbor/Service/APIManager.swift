//
//  Untitled.swift
//  CineHarbor
//
//  Created by Milena on 02/04/25.
//

import Foundation
import UIKit

enum MediaType: String {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
}

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let imageURL = "https://image.tmdb.org/t/p/w500"
    private let apiKey = "7cd33f57ce1734a36e86edb23ecef15f"
    
    // https://api.themoviedb.org/3/trending/all/week?api_key=SUA_API_KEY&language=pt-BR
    func getTrendingURL(_ mediaType: MediaType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/trending/\(mediaType.rawValue)/day"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "pt-BR")
        ]
        components.queryItems = queryItems
        
        return components.url
    }
    
    func fetchTrending(
        mediaType: MediaType = .all,
        completion: @escaping ([TrendingItem]?) -> Void
    ) {
        guard let url = getTrendingURL(mediaType) else {
            print("❌ URL inválida")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Erro: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ Dados vazios")
                completion(nil)
                return
            }

            do {
                let trending = try JSONDecoder().decode(TrendingResponse.self, from: data)
                completion(trending.results)
            } catch {
                print("❌ Erro ao decodificar JSON: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }

    func loadImage(of item: TrendingItem, into imageView: UIImageView) {
        guard let posterPath = item.posterPath, let url = URL(string: "\(imageURL)\(posterPath)") else {
            print("❌ URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao carregar imagem:", error?.localizedDescription ?? "desconhecido")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("❌ Não foi possível converter Data em UIImage")
            }
        }
        task.resume()
    }
}
