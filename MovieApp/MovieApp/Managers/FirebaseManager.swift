//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Firebase
import FirebaseCore
import FirebaseRemoteConfig

enum RemoteConfigKeys {
    static let splashTitle = "set_splash_title"
}

class FirebaseManager {

    private init() {}

    static func configurationFirebase() {
        FirebaseApp.configure()
    }

    struct AnalyticsLog {

        static func sendEvent(eventName: String, parameters: [String: Any]? = nil) {
            Analytics.logEvent(eventName, parameters: parameters)
        }

    }

    struct RemoteConfiguration {

        static let config = RemoteConfig.remoteConfig()

        static func configureRemoteConfig() {
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            FirebaseManager.RemoteConfiguration.config.configSettings = settings
        }

        static func setSplashTitle(completion: @escaping (String?) -> Void) {
            config.fetchAndActivate { status, error in
                switch status {
                case .successFetchedFromRemote:
                    let splashTitle = config.configValue(forKey: RemoteConfigKeys.splashTitle).stringValue
                    completion(splashTitle)
                default:
                    break
                }
            }
        }

    }

}
