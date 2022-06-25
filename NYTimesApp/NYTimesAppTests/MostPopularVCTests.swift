//
//  NYTimesAppTests.swift
//  NYTimesAppTests
//
//  Created by Arvind on 22/06/22.
//

import XCTest
@testable import NYTimesApp

class MostPopularVCTests: XCTestCase {
    
    var mostPopularVC: MostPopularVC!
    var viewModel: MostPopularVM!
    var mockViewModel: MostPopularVM!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mostPopularVC = storyboard.instantiateViewController(withIdentifier: "MostPopularVC") as? MostPopularVC
        _ = mostPopularVC.view
        viewModel = MostPopularVM(httpClient: HTTPClient())
        mockViewModel = MostPopularVM(httpClient: MockHTTPClient())
    }
    
    override func tearDown() {
        super.tearDown()
        mostPopularVC = nil
        viewModel = nil
    }
    
    func testOutletNil() {
        XCTAssertNotNil(mostPopularVC.tableView, "UITableView is nil")
    }
    
    func testAPICalling() {
        // Given
        let mostPopularVM = viewModel
        let expectation = self.expectation(description: "Testing API Calling")
        
        // When
        mostPopularVM?.getMostPopularNews(completion: { message, status in
            expectation.fulfill()
        })
        
        // Then
        waitForExpectations(timeout: 20) { error in
            XCTAssertEqual(mostPopularVM?.results?.count, 20)
        }
    }
    
    func testMockAPICalling() {
        // Given
        let mostPopularVM = mockViewModel
        let expectation = self.expectation(description: "Testing API Calling")
        
        // When
        mostPopularVM?.getMostPopularNews(completion: { message, status in
            expectation.fulfill()
        })
        
        // Then
        waitForExpectations(timeout: 20) { error in
            XCTAssertEqual(mostPopularVM?.results?.count, 20)
        }
    }
}
