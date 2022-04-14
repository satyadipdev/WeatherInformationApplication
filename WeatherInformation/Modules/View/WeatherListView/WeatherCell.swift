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
    
     func configure(_ weather: WeatherDetails) {
        self.cityNameLabel.text = weather.city
        self.temperatureLabel.text = weather.temperature.formatTemperature()
    }
}
