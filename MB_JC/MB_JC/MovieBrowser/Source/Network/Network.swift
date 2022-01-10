//
//  Network.swift
//  SampleApp
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.
//

import UIKit

enum NetworkURL {
    static let apiKey = "?api_key=5885c445eab51c7004916b9c0313e2d3"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let keySearchText = "$KEY_SEARCH_TEXT$"
    static let searchMovieURL = "\(baseURL)search/movie\(apiKey)&query=\(keySearchText)"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
}

enum NetworkError:Error, LocalizedError {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Incorrect url"
        case .other(let error):
            return error.localizedDescription
        }
    }
}

class Network {
    
    func get<T:Decodable>(_ model: T.Type, from url: String, completion: @escaping (Result<T, NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(model, from: data)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.other(error)))
                }
                return
            }
            fatalError()
        }
        .resume()
    }
    
    func getData(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            if let data = data {
                completion(.success(data))
                return
            }
            fatalError()
        }
        .resume()
    }
}
