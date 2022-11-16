//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import UIKit

enum NetworkError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidSearchedWord = "This word created an invalid request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid . Please try again."
    case emptyData = "No movies found"
}

class NetworkManager {

    static let shared = NetworkManager()
    private let apiKey = "89d41dac"
    lazy var baseURL = "http://www.omdbapi.com/?apikey=\(apiKey)"

    func getMovies(with word: String, completed: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let endpoint = baseURL + "&s=\(word)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidSearchedWord))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard
                let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SearchMovie.self, from: data)
                completed(.success(response.search ?? []))
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }

    func getMovieDetail(with id: String, completed: @escaping (Result<Movie, NetworkError>) -> Void) {
        let endpoint = baseURL + "&t=\(id)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidSearchedWord))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard
                let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(Movie.self, from: data)
                completed(.success(movie))
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }

}
