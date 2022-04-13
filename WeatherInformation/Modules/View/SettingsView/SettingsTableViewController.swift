//
//  SettingsTableViewController.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate: AnyObject {
    func settingsDone(settingsViewModel: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: update view model and dismiss view
    
    @IBAction private func done() {
        if let delegate = self.delegate {
            delegate.settingsDone(settingsViewModel: settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Tableview datasources and Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit 
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: SettingsCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.settingsCell, for: indexPath) as?  SettingsCell else {
            return UITableViewCell()
        }
        cell.configure(settingsViewModel, row: indexPath.row)
        return cell
    }
    
}
