//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    func setupCell(with movie: Movie) {
        movieTitle.text = movie.title
        movieYear.text = movie.year

        KingfisherHelper.getMovieImage(with: .cell, urlString: movie.poster) { [weak self] image in
            self?.movieImage.image = image
        }
    }
    
}
