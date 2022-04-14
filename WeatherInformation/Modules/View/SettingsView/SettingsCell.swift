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
    
    func configure(settings: SettingsViewModel, row: Int) {
        self.accessoryType = .none
        if settings.units.count >= row {
            let settingsItem = settings.units[row]
            self.textLabel?.text = settingsItem.displayName
            if settingsItem == settings.selectedUnit {
                self.accessoryType = .checkmark
            }
        }
    }
}
