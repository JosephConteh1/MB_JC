//
//  SearchResponse.swift.swift
//  MovieBrowser
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let page: Int
    let results: [Movie]
}
