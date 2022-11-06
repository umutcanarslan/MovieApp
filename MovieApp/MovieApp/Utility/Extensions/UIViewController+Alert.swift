//
//  UIViewController+Alert.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import UIKit

extension UIViewController {

    func showAlert(
        title: String? = nil,
        message: String? = nil,
        actionTitle: String = "OK",
        actionHandler: ((UIAlertAction) -> Void)? = nil,
        cancelHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))

        if let cancelHandler = cancelHandler {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler))
        }

        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

}
