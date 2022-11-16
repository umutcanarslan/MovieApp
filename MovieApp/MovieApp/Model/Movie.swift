//
//  Movie.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Foundation

struct Movie: Codable {
    let title: String?
    let overview: String?
    let year: String?
    let poster: String?
    let imdbRating: String?
    let imdbID: String?
    let imdbVotes: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case overview = "Plot"
        case year = "Year"
        case poster = "Poster"
        case imdbRating, imdbID, imdbVotes
    }
}
