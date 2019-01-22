//
//  DouughUsersUITests.swift
//  DouughUsersUITests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest

class DouughUsersUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicFlow() {
        let app = XCUIApplication()
        
        // Testing users page
        let usersTable = app.tables
        XCTAssertEqual(usersTable.cells.count, 10)
        let userCell1 = usersTable.cells.element(boundBy: 0)
        XCTAssertTrue(userCell1.staticTexts["Barry White"].exists)
        
        // Navigating to user Details
        userCell1.tap()
        
        // Testing user Details page
        XCTAssertTrue(app.staticTexts["Barry White"].exists)
        XCTAssertTrue(app.staticTexts["barry@white.com"].exists)
        XCTAssertTrue(app.staticTexts["ID: 5"].exists)
        
        // Back to Main Page
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Sort with Last Name
        app.buttons["Last"].tap()
        XCTAssertTrue(usersTable.cells.element(boundBy: 0).staticTexts["Benjamin Joseph Mark John Peter Simon Luke Chiong"].exists)
        XCTAssertTrue(usersTable.cells.element(boundBy: 1).staticTexts["Joanne Galit"].exists)
        XCTAssertTrue(usersTable.cells.element(boundBy: 2).staticTexts["Joe Joestar"].exists)
        
        
        // Sort with ID
        app.buttons["ID"].tap()
        XCTAssertTrue(usersTable.cells.element(boundBy: 0).staticTexts["Bob Ong"].exists)
        XCTAssertTrue(usersTable.cells.element(boundBy: 8).staticTexts["Edward Newgate"].exists)
        XCTAssertTrue(usersTable.cells.element(boundBy: 9).staticTexts["Tina Loria"].exists)
    }
}
