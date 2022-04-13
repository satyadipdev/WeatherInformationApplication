//
//  AlertHandler.swift
//  WeatherInformation
//
//  Created by Satyadip Singha on 12/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import UIKit

struct AlertHandler {

    static func showAlert(forMessage: String, title: String, defaultButtonTitle: String, sourceViewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: forMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultButtonTitle, style: .default)
        alertController.addAction(defaultAction)
        DispatchQueue.main.async {
            sourceViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
