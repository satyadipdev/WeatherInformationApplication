//
//  WeatherResponse.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String 
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
