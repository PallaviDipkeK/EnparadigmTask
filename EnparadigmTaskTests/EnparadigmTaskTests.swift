//
//  EnparadigmTaskTests.swift
//  EnparadigmTaskTests
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import XCTest
@testable import EnparadigmTask

class EnparadigmTaskTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.EnparadigmTask
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIResponse() {
        let viewModel = WeatherViewModel()
        viewModel.getData(city: "Delhi")
        let expectation = self.expectation(description: "validate API response")
        viewModel.completionHandler = {  (success, error, title, subtitle) in
            if success {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testViewModel() {
        let viewModel = WeatherViewModel()
        viewModel.getData(city: "Delhi")
        let expectation = self.expectation(description: "validate View Model")
        viewModel.completionHandler = {  (success, error, title, subtitle) in
            if success {
                XCTAssertNotNil(viewModel.model)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
