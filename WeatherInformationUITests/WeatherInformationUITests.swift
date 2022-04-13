//
//  WeatherInformationUITests.swift
//  WeatherInformationUITests
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest
@testable import WeatherInformation

class WeatherInformationUITests: XCTestCase {
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
    
    func testShouldDisplayAddCityInTitle() {
        contentViewPage.addNavigationBar.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.addCityNavigationBar.exists)
    }
    
    func testShouldDiplaySaveButton() {
        contentViewPage.addNavigationBar.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.buttonAdd.exists)
    }
    
    func testCityTextFiledIsExists() {
        contentViewPage.addNavigationBar.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.cityTextField.exists)
    }
    
    func testDefaultTextEntryShouldBePlaceholderTest() {
        contentViewPage.addNavigationBar.tap()
        timer.wait(for: 0.5)
        XCTAssertEqual(contentViewPage.cityTextField.value as? String, Constants.defaultCityText)
    }
    
    func testShouldDisplaySettingsInTitle() {
        contentViewPage.settingsNavBar.tap()
        timer.wait(for: 0.5)
        XCTAssert(contentViewPage.settingsNavigationBar.exists)
    }
    
    override func tearDown() {
        super.tearDown()
        timer = nil
    }
}
