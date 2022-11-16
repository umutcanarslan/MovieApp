//
//  UITableViewCell+Ext.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 15.11.2022.
//

import UIKit

extension UITableViewCell {

    static var reuseIdentifier = String(describing: self)

    static func getXib() -> UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
