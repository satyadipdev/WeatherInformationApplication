//
//  String+Extensions.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//
import Foundation

protocol WeatherServiceable {
    func getWeatherDetails(city: String, units: String, appID: String) async -> Result<WeatherResponse, RequestError>
}

struct WeatherService: HTTPClient, WeatherServiceable {
    func getWeatherDetails(city: String, units: String, appID: String) async -> Result<WeatherResponse, RequestError> {
        return await sendRequest(endpoint: WeatherEndpoint.weather(city: city, units: units, appID: appID), responseModel: WeatherResponse.self)
    }
}
