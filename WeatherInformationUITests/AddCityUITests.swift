//
//  AddCityUITests.swift
//  WeatherInformationUITests
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest

class AddCityUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var contentViewPage: ContentViewPage!
    var timer: Timer!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        timer = Timer()
        app.launch()
    }
    func testSavingAfterEnteringWrongInputShouldNavigatePreviousScreen() {
        contentViewPage.addNavigationBar.tap()
        contentViewPage.cityTextField.tap()
        contentViewPage.cityTextField.tap()
        contentViewPage.cityTextField.typeText("Londonnnnn") // Checking with wrong city name
        let saveButton = contentViewPage.btnSave
        saveButton.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.addCityNavigationBar.exists)
    }
    
    func testSavingAfterEnteringCorrectInputShouldNavigatePreviousScreen() {
        contentViewPage.addNavigationBar.tap()
        contentViewPage.cityTextField.tap()
        contentViewPage.cityTextField.typeText("London") // Checking with correct city name
        contentViewPage.btnSave.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.launchNavigationBar.exists)
    }
    
    func testCloseButtonPressShouldNavigatePreviusScreen() {
        contentViewPage.addNavigationBar.tap()
        timer.wait(for: 0.5)
        contentViewPage.btnClose.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.launchNavigationBar.exists)
    }
    
    func testAlertAvailabilityviewForWrongCityInput() {
        contentViewPage.addNavigationBar.tap()
        contentViewPage.cityTextField.tap()
        contentViewPage.cityTextField.typeText("Londonsss") // Checking with wrong city name
        contentViewPage.btnSave.tap()
        timer.wait(for: 2)
        XCTAssert(app.alerts.element.exists)
    }
    
    func testAlertWhenEnteredCityNIsBlank() {
        contentViewPage.addNavigationBar.tap()
        contentViewPage.cityTextField.tap()
        contentViewPage.cityTextField.typeText("") // Checking with blank city name
        contentViewPage.btnSave.tap()
        timer.wait(for: 2)
        XCTAssert(app.alerts.element.exists)
    }

    override func tearDown() {
        super.tearDown()
        timer = nil
    }
}
