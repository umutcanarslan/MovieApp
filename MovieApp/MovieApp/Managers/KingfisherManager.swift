//
//  KingfisherManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import UIKit
import Kingfisher

struct KingfisherHelper {

    static func getImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            // TODO: add placeholder image
            return
        }

        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(_):
                // TODO: add placeholder image
                completion(nil)
            }
        }
    }

}
