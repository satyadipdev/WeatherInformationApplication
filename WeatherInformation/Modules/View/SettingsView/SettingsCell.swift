//
//  SettingsCell.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 13/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit


class SettingsCell: UITableViewCell {
    
    // MARK: Updating settings cell
    
    func configure(_ settingsViewModel: SettingsViewModel, row: Int) {
        self.accessoryType = .none
        if settingsViewModel.units.count >= row {
            let settingsItem = settingsViewModel.units[row]
            self.textLabel?.text = settingsItem.displayName
            if settingsItem == settingsViewModel.selectedUnit {
                self.accessoryType = .checkmark
            }
        }
    }
}
