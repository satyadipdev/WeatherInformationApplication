//
//  WeatherListViewModel.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

protocol FetchWeatherDataDelegate: AnyObject {
    func didFetchWeatherData(weather: WeatherDetails)
}

protocol ErrorDuringDataFetchingDelegate: AnyObject {
    func didFailedWithError(error: RequestError)
}

class WeatherListViewModel {

    private var weatherDetails = [WeatherDetails]()
    private var weatherService = WeatherService()
    weak var delegateFetchData: FetchWeatherDataDelegate?
    weak var delegateFetchDataError: ErrorDuringDataFetchingDelegate?
    
    // MARK: Method to add weather deatils
    
    func addWeather(weather: WeatherDetails) {
        weatherDetails.append(weather)
    }
    
    // MARK: Return the number of city to be displayed
    
    func numberOfCityToBeListed(section: Int) -> Int {
        return weatherDetails.count
    }
    
    // MARK: Return weather details of specific index
    
    func weatherDetailsAtPosition(index: Int) -> WeatherDetails {
        return weatherDetails[index]
    }
    
    // MARK: Convert Fahrenheit to Celsius
    
    private func toCelsius() {
        weatherDetails = weatherDetails.map { weather in
            let weatherDetails = weather
            weatherDetails.temperature = (weather.temperature - 32) * 5/9
            return weatherDetails
        }
    }
    
    // MARK:  API to fetch data 
    
    public func fetchWeatherData(city: String) {
        Task(priority: .background) {
            let result = await weatherService.getWeatherDetails(city: city, units: Constants.unit(), appID: Constants.appID)
            getWeatherResponse(result: result)
        }
    }
    
    // MARK: Pass response to view for update
    
    public func getWeatherResponse(result :Result<WeatherResponse, RequestError>) {
        switch result {
        case .success(let response):
            let weather = WeatherDetails(weather: response)
            self.delegateFetchData?.didFetchWeatherData(weather: weather)
            
        case .failure(let error):
            self.delegateFetchDataError?.didFailedWithError(error: error)
        }
    }
    
    // MARK: Convert Celsius to Fahrenheit
    
    private func toFahrenheit() {
        weatherDetails = weatherDetails.map { weather in
            let weatherDetails = weather
            weatherDetails.temperature = (weatherDetails.temperature * 9/5) + 32
            return weatherDetails
        }
    }
    
    // MARK: Calling respective method to update unit
    
    func updateUnit(to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
}

class WeatherDetails {

    private let weather: WeatherResponse
    var temperature: Double

    init(weather: WeatherResponse) {
        self.weather = weather
        temperature = weather.main.temp
    }
    var city: String {
        return weather.name
    }

}
