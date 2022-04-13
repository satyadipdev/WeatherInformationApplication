//
//  SettingsViewModel.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

// MARK: - set case values as per API request parameter demands

enum Unit: String, CaseIterable {
    case celsius = "metric" 
    case fahrenheit = "imperial"
}

// MARK: - To Display unit on apploication screen

extension Unit {
    var displayName: String {
        switch self {
        case .celsius:
            return Constants.celcius
        case .fahrenheit:
            return Constants.fahrenheit
        }
    }
}

class SettingsViewModel {
    
    let units = Unit.allCases
    
    // get and Set unit values
    
    var selectedUnit: Unit? {
        get {
            let userDefaults = UserDefaults.standard
            let value = userDefaults.value(forKey: Constants.Units.defeultName) as? String ?? Unit.fahrenheit.rawValue
            
            var strUnit = Unit(rawValue: value)
            if value.isEmpty != true {
                strUnit =  Unit(rawValue: value)
            }
            return strUnit
        }
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue?.rawValue, forKey: Constants.Units.defeultName)
        }
    }
    
}
