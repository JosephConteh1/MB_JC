//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.

import Foundation

class SearchViewModel {
    
    var movieSelected: Movie?
    @Published private(set) var movies = [Movie]()
    private let networkManager = Network()
    
    func search(by name: String) {
        let url = NetworkURL.searchMovieURL.replacingOccurrences(of: NetworkURL.keySearchText, with: searchQuerySanitization(query: name))
        networkManager
            .get(SearchResponse.self, from: url) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    // priting in console
                    print(error.localizedDescription)
                }
            }
    }
    
    private func searchQuerySanitization(query: String) -> String {
        return query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
    }
    
    func download(posterPath: String?, completion: @escaping (Data?) -> Void) {
        guard let posterPath = posterPath else {
            completion(nil)
            return
        }
        let url = NetworkURL.baseImageURL.appending(posterPath)
        networkManager
            .getData(from: url) { result in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    // printing in console
                    print(error.localizedDescription)
                }
            }
    }
    
    func selectMovie(at index: Int) {
        movieSelected = movies[index]
    }
}
