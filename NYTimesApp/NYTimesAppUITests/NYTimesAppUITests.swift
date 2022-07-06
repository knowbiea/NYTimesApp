//
//  NYTimesAppUITests.swift
//  NYTimesAppUITests
//
//  Created by Arvind on 22/06/22.
//

import XCTest

class NYTimesAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testNavigationSearch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let navigationBar = app.navigationBars["NY Times Most Popular"]
        XCTAssertTrue(navigationBar.exists)
        
        let searchButton = navigationBar.buttons["search"]
        XCTAssertTrue(searchButton.exists, "Search Bar Button does not exist")
        
        searchButton.tap()
    }
    
    func testNavigationMore() throws {
        let app = XCUIApplication()
        app.launch()

        let navigationBar = app.navigationBars["NY Times Most Popular"]
        XCTAssertTrue(navigationBar.exists)

        let moreButton = navigationBar.buttons["more"]
        XCTAssertTrue(moreButton.exists, "More Bar Button does not exist")

        moreButton.tap()
    }
    
    func testNavigationMenu() throws {
        let app = XCUIApplication()
        app.launch()

        let navigationBar = app.navigationBars["NY Times Most Popular"]
        XCTAssertTrue(navigationBar.exists)

        let menuButton = navigationBar.buttons["menu"]
        XCTAssertTrue(menuButton.exists, "Menu Bar Button does not exist")

        menuButton.tap()
    }
    
    
    func testTableView() throws {
        let app = XCUIApplication()
        app.launch()

        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.exists, "Table does not exist")
        
        let complaintCell = tableView.cells.firstMatch
        XCTAssert(complaintCell.waitForExistence(timeout: 10))
        
        let titleLabel = complaintCell.staticTexts["titleLabel"]
        XCTAssertTrue(titleLabel.exists, "Title Label does not exist")
        
        let title = complaintCell.staticTexts["titleLabel"].label
        XCTAssertEqual(title, "Woman Is Fatally Shot While Pushing Baby in Stroller on Upper East Side")

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
