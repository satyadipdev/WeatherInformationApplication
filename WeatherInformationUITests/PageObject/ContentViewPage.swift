//
//  ContentViewPage.swift
//  WeatherInformationUITests
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import Foundation
import XCTest

class ContentViewPage {
    var app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var cityTextField: XCUIElement {
        app.textFields["cityTextField"]
    }
    
    var launchNavigationBar: XCUIElement {
        app.navigationBars["Weather Information"]
    }
    
    var settingsNavigationBar: XCUIElement {
        app.navigationBars["Settings"]
    }
    
    var addCityNavigationBar: XCUIElement {
        app.navigationBars["Add City"]
    }
    
    var buttonAdd: XCUIElement {
        app.buttons["Add"]
    }
    
    var addNavigationBar: XCUIElement {
        app.navigationBars.buttons["Add"]
    }
    
    var settingsNavBar: XCUIElement {
        app.navigationBars["Weather Information"].buttons["Settings"]
    }
    
    var btnSave: XCUIElement {
        app.buttons["save"]
    }
    
    var btnSettingsDone: XCUIElement {
        app.navigationBars.buttons["Done"]
    }
    
    var btnClose: XCUIElement {
        app.navigationBars.buttons["Close"]
    }
    
}
