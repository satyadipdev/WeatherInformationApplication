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
    }
    
    // MARK: testfield validation and API caling
    
    @IBAction private func saveCityButtonPressed() {
        if cityNameTextField.text?.count ?? 0 > 0 {
            self.weatherApiCall()
        } else {
            AlertHandler.showAlert(forMessage: Constants.ShowAlert.enterCityName, title: Constants.ShowAlert.alertTitle, defaultButtonTitle: Constants.ShowAlert.okTitle, sourceViewController: self)
        }
    }

    // MARK: - api calling
    
    private func weatherApiCall() {
        
        if ConnectionManager.shared.hasConnectivity() {
            if let city = cityNameTextField.text {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                weatherListViewModel.fetchData(city: city) { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    switch result {
                    case .success(let response):
                        let weatherVM = WeatherViewModel(weather: response)
                        self.delegate?.addWeatherDidSave(weatherVM: weatherVM)
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    case .failure(let error):
                        AlertHandler.showAlert(forMessage: error.customMessage, title: Constants.ShowAlert.alertTitle, defaultButtonTitle: Constants.ShowAlert.okTitle, sourceViewController: self)
                    }
                }
            }
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
