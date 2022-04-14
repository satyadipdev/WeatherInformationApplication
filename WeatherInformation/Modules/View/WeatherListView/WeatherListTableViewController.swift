//
//  WeatherListTableViewController.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate {
    
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Unit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: Constants.Units.defaultName) as? String {
            self.lastUnitSelection = Unit(rawValue: value)
        }
    }
    
    // MARK: update viewmodel and reload
    
     func addWeatherDidSave(weather: WeatherDetails) {
         weatherListViewModel.addWeather(weather: weather)
         DispatchQueue.main.async {
             self.tableView.reloadData()
         }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifier.segueAddWeatherCityVC {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        } else if segue.identifier == Constants.SegueIdentifier.segueSettingsettingsTableViewController {
            prepareSegueForSettingsTableViewController(segue: segue)
        }
    }
    
    private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
        let navigationController = segue.destination as? UINavigationController
        let settingsTableViewController = navigationController?.viewControllers.first as? SettingsTableViewController
        settingsTableViewController?.delegate = self
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        let navigationController = segue.destination as? UINavigationController
        let addWeatherCityViewController = navigationController?.viewControllers.first as? AddWeatherCityViewController
        addWeatherCityViewController?.delegateAddWeather = self
    }
    
    // MARK: tableview Datasources
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfCityToBeListed(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: WeatherCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.weatherCell, for: indexPath) as?  WeatherCell else {
            return UITableViewCell()
        }
        let weather = weatherListViewModel.weatherDetailsAtPosition(index: indexPath.row)
        cell.configure(weather)
        return cell
    }
    
}

extension WeatherListTableViewController: SettingsDelegate {
    
    // MARK: updating unit and respective value and update UI
    
     func settingsDone(settings: SettingsViewModel) {
        if lastUnitSelection?.rawValue != settings.selectedUnit?.rawValue {
            weatherListViewModel.updateUnit(to: settings.selectedUnit ?? Unit.fahrenheit)
            lastUnitSelection = Unit(rawValue: settings.selectedUnit?.rawValue ?? Unit.fahrenheit.rawValue) ?? Unit.fahrenheit
            tableView.reloadData()
        }
    }
}
