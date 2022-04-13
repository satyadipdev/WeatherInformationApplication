//
//  SettingsUITests.swift
//  WeatherInformationUITests
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest
@testable import WeatherInformation

class SettingsUITests: XCTestCase {
        
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    var timer: Timer!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        timer = Timer()
        continueAfterFailure = false
        app.launch()
    }
        
    func testCelciusSelectionCellExistance() {
        contentViewPage.settingsNavBar.tap()
        XCTAssert(app.tables.staticTexts[Constants.celcius].exists)
    }
    
    func testArbiratyChangeUnitsAndCheckNavaigationWorkStatus() {
        contentViewPage.settingsNavBar.tap()
        app.tables.staticTexts[Constants.celcius].tap()
        app.tables.staticTexts[Constants.fahrenheit].tap()
        app.tables.staticTexts[Constants.celcius].tap()
        contentViewPage.btnSettingsDone.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.launchNavigationBar.exists)
    }
    
    func testFahrenheitSelectionCellExistance() {
        contentViewPage.settingsNavBar.tap()
        XCTAssert(app.tables.staticTexts[Constants.fahrenheit].exists)
    }
    
    func testAppNavigateNextScreenAfterCelciusSelectionAndDoneButtonPressed() {
        contentViewPage.settingsNavBar.tap()
        app.tables.staticTexts[Constants.celcius].tap()
        timer.wait(for: 0.5)
        contentViewPage.btnSettingsDone.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.launchNavigationBar.exists)
    }
    
    func testAppNavigateNextScreenAfterFahrenheitSelectionAndDoneButtonPressed() {
        contentViewPage.settingsNavBar.tap()
        app.tables.staticTexts[Constants.fahrenheit].tap()
        timer.wait(for: 0.5)
        contentViewPage.btnSettingsDone.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.launchNavigationBar.exists)
    }
    
    override func tearDown() {
        super.tearDown()
        timer = nil
    }
}
