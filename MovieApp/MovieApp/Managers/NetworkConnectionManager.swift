//
//  NetworkConnectionManager.swift
//  MovieApp
//
//  Created by Umut Can Arslan on 31.10.2022.
//

import Foundation
import Alamofire

final class NetworkConnectionManager {

    var connectionManager = NetworkReachabilityManager()
    static let shared = NetworkConnectionManager()

    private init() { }

    func checkNetworkConnection(completion: ((_ isNetworkConnected: Bool) ->  Void)? = nil) {
        connectionManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .reachable:
                completion?(true)
            default:
                completion?(false)
            }
        })
    }

}
