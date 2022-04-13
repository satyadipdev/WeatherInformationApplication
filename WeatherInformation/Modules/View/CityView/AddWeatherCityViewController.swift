//
//  AddWeatherCityViewController.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Reachability

protocol AddWeatherDelegate: AnyObject {
    func addWeatherDidSave(weatherVM: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var cityNameTextField: UITextField!
    private var weatherService = WeatherService()
    weak var delegate: AddWeatherDelegate?
    private let reachability = try? Reachability()
    private var weatherListViewModel = WeatherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherListViewModel.delegateFetchData = self
        weatherListViewModel.delegateFetchDataError = self
    }
    
    // MARK: testfield validation and API caling
    
    @IBAction private func saveCityButtonPressed() {
        if let city = cityNameTextField.text {
            self.getWeatherForCity(city : city)
        } else {
            AlertHandler.showAlert(forMessage: Constants.ShowAlert.enterCityName, title: Constants.ShowAlert.alertTitle, defaultButtonTitle: Constants.ShowAlert.okTitle, sourceViewController: self)
        }
    }

    // MARK: - Get weather for entered city
    
    private func getWeatherForCity(city : String) {
        if ConnectionManager.shared.hasConnectivity() {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            weatherListViewModel.fetchWeatherData(city: city)
        } else {
            AlertHandler.showAlert(forMessage: Constants.Network.errorMessage, title: Constants.Network.errorTitle, defaultButtonTitle: Constants.ShowAlert.okTitle, sourceViewController: self)
        }
    }
    
    // MARK: - close button Action
    
    @IBAction private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityNameTextField.resignFirstResponder()
        return true
    }
}

extension AddWeatherCityViewController: FetchWeatherDataDelegate {
    
    // MARK: - Receive weather data
    
    func didFetchWeatherData(weatherVM: WeatherViewModel) {
        self.delegate?.addWeatherDidSave(weatherVM: weatherVM)
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddWeatherCityViewController: ErrorDuringDataFetchingDelegate {
    
    // MARK: - Display alert for getting error in weather response
    
    func didFailedWithError(error: RequestError) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        AlertHandler.showAlert(forMessage: error.customMessage, title: Constants.ShowAlert.alertTitle, defaultButtonTitle: Constants.ShowAlert.okTitle, sourceViewController: self)
    }
}
