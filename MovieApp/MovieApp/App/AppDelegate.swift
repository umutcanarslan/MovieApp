//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 31.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = SplashViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

}
