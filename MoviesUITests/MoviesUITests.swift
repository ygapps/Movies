//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Youssef on 5/18/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import XCTest

class MoviesUITests: XCTestCase {

    override func setUpWithError() throws {
    
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testValidPersonalMovieEntry() throws {
       
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["Movies"].buttons["Item"].tap()
        
        app.textFields["Movie Title"].tap()
        app.textFields["Movie Title"].typeText("The Platform")
                
        let background = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        background.tap()
        
        app.datePickers/*@START_MENU_TOKEN@*/.pickerWheels["2020"]/*[[".pickers.pickerWheels[\"2020\"]",".pickerWheels[\"2020\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        app.buttons["Add"].tap()
        
        XCTAssertTrue(app.alerts["Missing Field"].exists)

        app.alerts["Missing Field"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
