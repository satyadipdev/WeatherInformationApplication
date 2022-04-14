//
//  SettingsViewModelTests.swift
//  WeatherInformationTests
//
//  Created by Satyadip Singha on 06/04/22.//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest
@testable import WeatherInformation

class SettingsViewModelTests: XCTestCase {

    private var settingsViewModel: SettingsViewModel?
    
    override func setUp() {
        super.setUp()
        self.settingsViewModel = SettingsViewModel()
    }
    
    func testShouldReturnCorrectDisplayNameForFahrenheit() {
        XCTAssertEqual(self.settingsViewModel?.selectedUnit?.displayName, Constants.fahrenheit)
    }
    
    func testShouldMakeSureThatDefaultSelectedUnitIsFahrenheit() {
        XCTAssertEqual(settingsViewModel?.selectedUnit, .fahrenheit)
    }
    
    func testShouldBeAbleToSaveUserUnitSelection() {
        self.settingsViewModel?.selectedUnit = .celsius
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: Constants.Units.defaultName))
        XCTAssertEqual(self.settingsViewModel?.selectedUnit?.displayName, Constants.celsius)
        self.settingsViewModel?.selectedUnit = .fahrenheit
        XCTAssertNotNil(userDefaults.value(forKey: Constants.Units.defaultName))
        XCTAssertEqual(self.settingsViewModel?.selectedUnit?.displayName, Constants.fahrenheit)
    }
    
    override func tearDown() {
        super.tearDown()
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Constants.Units.defaultName)
        self.settingsViewModel = nil
    }
}
