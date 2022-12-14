//
//  SearchMovie.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Foundation

struct SearchMovie: Codable {
    let search: [Movie]?
    let totalResults: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
