//
//  ConnectionManager.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 12/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Reachability
class ConnectionManager {

    static let shared = ConnectionManager()
    private init () {}

    func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability()
            var isNetworkReachable = false
            if reachability.connection == .wifi || reachability.connection == .cellular {
                isNetworkReachable = true
            }
            return isNetworkReachable
        } catch {
            return false
        }
    }
}
