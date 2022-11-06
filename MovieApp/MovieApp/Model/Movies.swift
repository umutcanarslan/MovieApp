//
//  Movie.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Foundation

struct Movies: Codable {
    let title: String
    let year: String
    let released: String
    let poster: String
    let imdbRating, imdbID: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case poster = "Poster"
        case imdbRating, imdbID
    }
}
