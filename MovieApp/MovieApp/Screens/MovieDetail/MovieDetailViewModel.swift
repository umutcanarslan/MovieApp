//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 16.11.2022.
//

import Foundation

struct MovieDetailViewModelState {
    enum MovieDetailStateChange {
        case idle
        case loading(Bool)
        case success(Movie?)
        case error(NetworkError)
    }
}

class MovieDetailViewModel {

    private let imdbID: String
    private(set) var state = MovieDetailViewModelState()
    var detailState: ((MovieDetailViewModelState.MovieDetailStateChange) -> Void)?

    private func emit(change: MovieDetailViewModelState.MovieDetailStateChange) {
        DispatchQueue.main.async {
            self.detailState?(change)
        }
    }

    init(imdbID: String) {
        self.imdbID = imdbID
        emit(change: .idle)
    }

    func getMovieDetail() {
        emit(change: .loading(true))

        NetworkManager.shared.getMovieDetail(with: imdbID) { [weak self]  result in
            self?.emit(change: .loading(false))

            switch result {
            case .success(let movie):
                self?.emit(change: .success(movie))
            case .failure(let error):
                self?.emit(change: .error(error))
            }
        }
    }

}
