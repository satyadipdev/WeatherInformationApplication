//
//  Timer.swift
//  WeatherInformationUITests
//
//  Created by Satyadip Singha on 10/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

import XCTest

class Timer: XCTestCase {

    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }

}
