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
        if let value = userDefaults.value(forKey: Constants.Units.defeultName) as? String {
            self.lastUnitSelection = Unit(rawValue: value)
        }
    }
    
    // MARK: update viewmodel and reload
    
     func addWeatherDidSave(weatherVM: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(weatherVM)
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
        let nav = segue.destination as? UINavigationController
        let settingsTVC = nav?.viewControllers.first as? SettingsTableViewController
        settingsTVC?.delegate = self
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        let nav = segue.destination as? UINavigationController
        let addWeatherCityVC = nav?.viewControllers.first as? AddWeatherCityViewController
        addWeatherCityVC?.delegate = self
    }
    
    // MARK: tableview DataSources
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: WeatherCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.weatherCell, for: indexPath) as?  WeatherCell else {
            return UITableViewCell()
        }
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherVM)
        return cell
    }
    
}

extension WeatherListTableViewController: SettingsDelegate {
    
    // MARK: updating unit and respective value and update UI
    
     func settingsDone(settingsViewModel settingsVM: SettingsViewModel) {
        if lastUnitSelection?.rawValue != settingsVM.selectedUnit?.rawValue {
            weatherListViewModel.updateUnit(to: settingsVM.selectedUnit ?? Unit.fahrenheit)
            lastUnitSelection = Unit(rawValue: settingsVM.selectedUnit?.rawValue ?? Unit.fahrenheit.rawValue) ?? Unit.fahrenheit
            tableView.reloadData()
        }
    }
}
