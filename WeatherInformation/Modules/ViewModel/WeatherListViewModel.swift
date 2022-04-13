//
//  WeatherListViewModel.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation

protocol FetchWeatherDataDelegate: AnyObject {
    func didFetchWeatherData(weatherVM: WeatherViewModel)
}

protocol ErrorDuringDataFetchingDelegate: AnyObject {
    func didFailedWithError(error: RequestError)
}

class WeatherListViewModel {
    
    private(set) var weatherViewModels = [WeatherViewModel]()
    private var weatherService = WeatherService()
    weak var delegateFetchData: FetchWeatherDataDelegate?
    weak var delegateFetchDataError: ErrorDuringDataFetchingDelegate?
    
    func addWeatherViewModel(_ weatherVM: WeatherViewModel) {
        weatherViewModels.append(weatherVM)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    // MARK: Convert Fahrenheit to Celsius
    
    private func toCelsius() {
        
        weatherViewModels = weatherViewModels.map { weatherVM in
            let weatherModel = weatherVM
            weatherModel.temperature = (weatherModel.temperature - 32) * 5/9
            return weatherModel
        }
        
    }
    
    // MARK:  API to fetch data 
    
    public func fetchWeatherData(city: String) {
        Task(priority: .background) {
            let result = await weatherService.getWeatherDetails(city: city, units: Constants.unit(), appID: Constants.appID)
            getWeatherResponse(result: result)
        }
    }
    
    // MARK: Pass response to view 
    
    public func getWeatherResponse(result :Result<WeatherResponse, RequestError>) {
        switch result {
        case .success(let response):
            let weatherVM = WeatherViewModel(weather: response)
            self.delegateFetchData?.didFetchWeatherData(weatherVM: weatherVM)
            
        case .failure(let error):
            self.delegateFetchDataError?.didFailedWithError(error: error)
        }
    }
    
    // MARK: Convert Celsius to Fahrenheit
    
    private func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { weatherVM in
            let weatherModel = weatherVM
            weatherModel.temperature = (weatherModel.temperature * 9/5) + 32
            return weatherModel
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

class WeatherViewModel {

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
