//
//  Movie.swift
//  MovieBrowser
//
//  Created by Joseph Conteh on 14/12/21.
//  Copyright © 2021 Ebay. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    let originalTitle: String
    let releaseDateString: String?
    let voteAverage: Double?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case releaseDateString = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case overview
    }
    
    lazy var releaseDateMediumStyle: String? = {
        guard let releaseDateString = releaseDateString
        else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        guard let date = dateFormatter.date(from: releaseDateString)
        else { return nil }
        dateFormatter.dateFormat = nil
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }()
    
}
