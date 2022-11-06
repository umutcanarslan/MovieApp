//
//  AppRouterManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import UIKit

enum AppScreens {
    case splash
    case movieList
    case movieDetail(_ id: Int?)

    var viewController: UIViewController {
        switch self {
        case .splash:
            return SplashViewController()
        case .movieList:
            return MovieListViewController()
        case .movieDetail:
            return MovieListViewController()
        }
    }

}

class AppRouterManager {

    static let shared = AppRouterManager()

    func goToScreen(screen: AppScreens) {
        let viewController = UINavigationController(rootViewController: screen.viewController)
        viewController.modalTransitionStyle = .coverVertical
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }

}
