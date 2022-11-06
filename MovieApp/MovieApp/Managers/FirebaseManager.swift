//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 6.11.2022.
//

import Firebase
import FirebaseRemoteConfig

struct FirebaseManager {

    struct RemoteConfig {

    }

    static func configurationFirebase() {
        FirebaseApp.configure()
    }

}

