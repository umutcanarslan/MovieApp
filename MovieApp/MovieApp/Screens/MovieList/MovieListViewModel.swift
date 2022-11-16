//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import Foundation

struct MovieListViewModelState {
    enum MovieListStateChange {
        case idle
        case loading(Bool)
        case success
        case error(NetworkError)
    }

    var movies: [Movie] = []
}

class MovieListViewModel {

    private(set) var state = MovieListViewModelState()
    var listState: ((MovieListViewModelState.MovieListStateChange) -> Void)?

    init() {
        emit(change: .idle)
    }

    private func emit(change: MovieListViewModelState.MovieListStateChange) {
        DispatchQueue.main.async {
            self.listState?(change)
        }
    }

    func getMovieList(with searchText: String) {
        emit(change: .loading(true))
        state.movies = []

        NetworkManager.shared.getMovies(with: searchText) { result in
            self.emit(change: .loading(false))

            switch result {
            case .success(let movies):
                self.state.movies = movies
                self.state.movies.isEmpty ? self.emit(change: .error(.emptyData)) : self.emit(change: .success)
            case .failure(let error):
                self.emit(change: .error(error))
            }
        }
    }



}
