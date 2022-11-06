//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 31.10.2022.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var splashTitle: UILabel!

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
        FirebaseManager.RemoteConfiguration.setSplashTitle { title in
            if let title = title {
                self.splashTitle.text = title
            } else {
                self.showAlertForBadNetwork()
            }
        }

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
