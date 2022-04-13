//
//  Constants.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

struct Constants {
    static let appID = "ef0fd9866ca027e0dca474cee84c53be"
    static let tableViewRowHeight = 100.0
    static let urlReachability = "www.google.com"
    static let unit = {
        return (UserDefaults.standard.value(forKey: Units.defeultName) as? String) ?? "imperial"
    }
    static let defaultCityText = "Enter City"
    static let celcius = "Celcius"
    static let fahrenheit = "Fahrenheit"
    static let mockURLString = "https://api.openweathermap.org/data/2.5/weather?q=Kerala&appid=ef0fd9866ca027e0dca474cee84c53be&units=imperial"
    static var sessionConfiguration = URLSessionConfiguration.default
    struct Cells {
        static let weatherCell = "WeatherCell"
        static let settingsCell = "SettingsCell"
    }
    struct SegueIdentifier {
        static let segueAddWeatherCityVC = "AddWeatherCityViewController"
        static let segueSettingsettingsTableViewController = "SettingsTableViewController"
    }
    struct Units {
        static let defeultName =  "unit"
    }
    struct ShowAlert {
        static let enterCityName = "Please enter city name"
        static let okTitle = "OK"
        static let alertTitle = "Alert!"
//        static let networkError = "Internet connection is not available"
    }
    static func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json
    }
    struct Network {
        static let errorMessage = "Please check your internet connection and try again"
        static let errorTitle = "No internet connection"
    }
}
