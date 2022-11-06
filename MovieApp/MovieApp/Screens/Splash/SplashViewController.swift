//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 31.10.2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkInternetConnection()
    }

    private func checkInternetConnection() {
        NetworkConnectionManager.shared.checkNetworkConnection { isNetworkConnected in
            switch isNetworkConnected {
            case true:
                self.setText()
            case false:
                self.showAlertForBadNetwork()
            }
        }
    }

    private func setText() {
        // TODO: remote config ile gelen text'i ekrana yazdır

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.presentMovieListScreen()
        }
    }

    private func showAlertForBadNetwork() {
        showAlert(
            title: "No Internet Connection",
            message: "The application cannot be accessed because your internet is not available.",
            actionTitle: "Retry") { [weak self] _ in
                self?.checkInternetConnection()
            } cancelHandler: { _ in
                exit(0)
            }

    }

    private func presentMovieListScreen() {
        // TODO: router yapısı oluştur ve present işini orada yap
    }

}
