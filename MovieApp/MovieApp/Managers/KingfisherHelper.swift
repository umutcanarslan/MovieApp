//
//  KingfisherHelper.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import UIKit
import Kingfisher

enum MovieImageType: String {
    case cell = "placeholderCell"
    case detail = "placeholderDetail"
}

struct KingfisherHelper {

    static func getMovieImage(with imageType: MovieImageType, urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else {
            completion(KingfisherHelper.setPlaceholderImage(with: imageType))
            return
        }

        guard let url = URL(string: urlString) else {
            completion(KingfisherHelper.setPlaceholderImage(with: imageType))
            return
        }

        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(_):
                completion(KingfisherHelper.setPlaceholderImage(with: imageType))
            }
        }
    }

    static func setPlaceholderImage(with type: MovieImageType) -> UIImage? {
        switch type {
        case .cell:
            return UIImage(named: MovieImageType.cell.rawValue)
        case .detail:
            return UIImage(named: MovieImageType.detail.rawValue)
        }
    }
}
