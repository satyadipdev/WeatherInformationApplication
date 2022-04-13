//
//  Double+Extensions.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

extension Double {
    
    // MARK: - convert temperature to specific format
    
    func formatTemperature() -> String {
        return (Constants.unit() == Unit.fahrenheit.rawValue) ? String(format: "%.0f°F", self) : String(format: "%.0f°C", self)
    }
}
