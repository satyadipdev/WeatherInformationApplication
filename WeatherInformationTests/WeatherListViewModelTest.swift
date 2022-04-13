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

    private var weatherListVM: WeatherListViewModel?
    var weatherService = WeatherService()
    
    override func setUp() {
        super.setUp()
        self.weatherListVM = WeatherListViewModel()
        self.setMockForWeatherListViewModel()
        Constants.sessionConfiguration = DataMocker.getSessionConfiguration()
    }
    func setMockForWeatherListViewModel() {
        let weatherVM = WeatherViewModel(weather: WeatherResponse(name: "Kerala", main: Weather(temp: 40, humidity: 10)))
        self.weatherListVM?.addWeatherViewModel(weatherVM)
    }
    func testToCelcius() {
        XCTAssertEqual(self.weatherListVM?.numberOfRows(0), 1)
        XCTAssertNotNil(self.weatherListVM?.modelAt(0))
        self.weatherListVM?.updateUnit(to: Unit.celsius)
        let weatherModelcelsius = self.weatherListVM?.modelAt(0)
        XCTAssertEqual(weatherModelcelsius?.temperature, 4.444444444444445)
    }
    func testToFahrenheit() {
        self.weatherListVM?.updateUnit(to: Unit.fahrenheit)
        let weatherModel = self.weatherListVM?.modelAt(0)
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
                let weatherVM = WeatherViewModel(weather: response)
                XCTAssertEqual(weatherVM.city, "Kolkata")
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
                let weatherVM = WeatherViewModel(weather: response)
                XCTAssertEqual(weatherVM.city, "Kolkata")
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
                let weatherVM = WeatherViewModel(weather: response)
                XCTAssertEqual(weatherVM.city, "Kolkata")
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
                let weatherVM = WeatherViewModel(weather: response)
                XCTAssertEqual(weatherVM.city, "Kolkata")
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
        self.weatherListVM = nil
    }
}
