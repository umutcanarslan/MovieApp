//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 16.11.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieVoteCount: UILabel!

    private let viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetail()
        viewModel.detailState = viewModelObserve
        setupUI()
    }

    private func setupUI() {
        navigationController?.title = "Movie Detail"
        view.backgroundColor = .systemBackground
    }

    func sendEvent(movieInfo: Movie) {
        FirebaseManager.AnalyticsLog.sendEvent(eventName: "movie_Detail", parameters: [
            "movieTitle" : movieInfo.title ?? "Unkown",
            "movieYear" : movieInfo.year ?? "Unkown",
            "movieRating" : movieInfo.imdbRating ?? "Unkown",
            "movieVoteCount" : movieInfo.imdbVotes ?? "Unkown"
        ])
    }

    func viewModelObserve(change: MovieDetailViewModelState.MovieDetailStateChange) {
        viewModel.detailState = { [weak self] state in
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success(let movie):
                guard let movie = movie else {
                    self?.dismiss(animated: true)
                    return
                }

                self?.sendEvent(movieInfo: movie)
                self?.setupDetail(movieDetail: movie)
            case .error:
                break
            }
        }

    }

    func setupDetail(movieDetail: Movie) {
        movieTitle.text = movieDetail.title
        movieOverview.text = movieDetail.overview
        movieRating.text = movieDetail.imdbRating
        movieRating.textColor = .systemYellow
        movieReleaseDate.text = movieDetail.year
        movieVoteCount.text = "Vote Count: \(movieDetail.imdbVotes ?? "0")"

        KingfisherHelper.getMovieImage(with: .detail, urlString: movieDetail.poster) { [weak self] image in
            self?.movieImage.image = image
        }
    }

}
