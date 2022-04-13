//
//  WeatherCell.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak private var cityNameLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
    // MARK: Updating weather cell
    
     func configure(_ weatherVM: WeatherViewModel) {
        self.cityNameLabel.text = weatherVM.city
        self.temperatureLabel.text = weatherVM.temperature.formatTemperature()
    }
}
