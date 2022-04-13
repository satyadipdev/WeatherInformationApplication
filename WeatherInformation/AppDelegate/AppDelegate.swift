//
//  AppDelegate.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 06/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCommonNavigationBar()
        setupDefaultSettings()
        return true
    }
    
    private func setupCommonNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 105/255, green: 78/255, blue: 34/255, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 122/255, green: 62/255, blue: 75/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }

    private func setupDefaultSettings() {
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: Constants.Units.defeultName) == nil {
            userDefaults.set(Unit.fahrenheit.rawValue, forKey: Constants.Units.defeultName)
        }
    }
}
