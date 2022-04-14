//
//  WeatherListViewModelTest.swift
//  WeatherInformationTests
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest
@testable import WeatherInformation

class WeatherListViewModelTest: XCTestCase {

    private var weatherList: WeatherListViewModel?
    var weatherService = WeatherService()
    
    override func setUp() {
        super.setUp()
        self.weatherList = WeatherListViewModel()
        self.setMockForWeatherListViewModel()
        Constants.sessionConfiguration = DataMocker.getSessionConfiguration()
    }
    
    func setMockForWeatherListViewModel() {
        let weatherDetails = WeatherDetails(weather: WeatherResponse(name: "Kerala", main: Weather(temp: 40, humidity: 10)))
        self.weatherList?.addWeather(weather: weatherDetails)
    }
    
    func testToCelsius() {
        XCTAssertEqual(self.weatherList?.numberOfCityToBeListed(section: 0), 1)
        XCTAssertNotNil(self.weatherList?.weatherDetailsAtPosition(index: 0))
        self.weatherList?.updateUnit(to: Unit.celsius)
        let weatherModelcelsius = self.weatherList?.weatherDetailsAtPosition(index: 0)
        XCTAssertEqual(weatherModelcelsius?.temperature, 4.444444444444445)
    }
    
    func testToFahrenheit() {
        self.weatherList?.updateUnit(to: Unit.fahrenheit)
        let weatherModel = self.weatherList?.weatherDetailsAtPosition(index: 0)
        XCTAssertEqual(weatherModel?.temperature, 104.0)
    }
    
    func testWeatherServiceApiSuccess() {
        let mockedData = Constants.readJSONFromFile(fileName: "Weather") as? [String: Any] ?? [:]
        DataMocker.setMockedData(mockData: mockedData,
                                     requestUrl: DataMocker.getServerUrl(),
                                     statusCode: 200)
        let expectation = self.expectation(description: "Success")
        fetchData(city: "Kolkata") { result in
            switch result {
            case .success(let response):
                let weatherDetails = WeatherDetails(weather: response)
                XCTAssertEqual(weatherDetails.city, "Kolkata")
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWeatherServiceApiFailure() {
        DataMocker.setMockedData(mockData: [:],
                                     requestUrl: DataMocker.getServerUrl(),
                                     statusCode: 200)
        let expectation = self.expectation(description: "Success")
        fetchData(city: "Kolkata") { result in
            switch result {
            case .success(let response):
                let weatherDetails = WeatherDetails(weather: response)
                XCTAssertEqual(weatherDetails.city, "Kolkata")
            case .failure(let error):
                print(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWeatherServiceApiBadRequest() {
        DataMocker.setMockedData(mockData: [:],
                                     requestUrl: DataMocker.getServerUrl(),
                                     statusCode: 401)
        let expectation = self.expectation(description: "Success")
        fetchData(city: "Kolkata") { result in
            switch result {
            case .success(let response):
                let weatherDetails = WeatherDetails(weather: response)
                XCTAssertEqual(weatherDetails.city, "Kolkata")
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWeatherServiceApiUnownError() {
        DataMocker.setMockedData(mockData: [:],
                                     requestUrl: DataMocker.getServerUrl(),
                                     statusCode: 402)
        let expectation = self.expectation(description: "Success")
        fetchData(city: "Kolkata") { result in
            switch result {
            case .success(let response):
                let weatherDetails = WeatherDetails(weather: response)
                XCTAssertEqual(weatherDetails.city, "Kolkata")
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
   
    private func fetchData(city: String, completion: @escaping (Result<WeatherResponse, RequestError>) -> Void) {
        Task(priority: .background) {
            let result = await weatherService.getWeatherDetails(city: city, units: Constants.unit(), appID: Constants.appID)
            completion(result)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        Constants.sessionConfiguration = URLSessionConfiguration.default
        self.weatherList = nil
    }
}
