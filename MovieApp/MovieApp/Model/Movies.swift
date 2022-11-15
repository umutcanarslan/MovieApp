//
//  Movie.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Foundation

struct Movies: Codable {
    let title: String?
    let year: String?
    let poster: String?
    let imdbID: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID
    }
}
