//
//  NYTimesAppTests.swift
//  NYTimesAppTests
//
//  Created by Arvind on 22/06/22.
//

import XCTest
@testable import NYTimesApp

class NYTimesAppTests: XCTestCase {
    
    var mostPopularVC: MostPopularVC!
    var viewModel: MostPopularVM!
    var bundle: Bundle!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mostPopularVC = storyboard.instantiateViewController(withIdentifier: "MostPopularVC") as? MostPopularVC
        _ = mostPopularVC.view
        viewModel = MostPopularVM()
        bundle = Bundle(for: type(of: self))
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
            XCTAssertNotNil(mostPopularVM?.results)
        }
    }
    
    func testMockDataAPICalling1() {
        // Given
        let mostPopularVM = viewModel
        guard let path = bundle.url(forResource: "MostPopular", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Testing API Calling")
        
        HTTPClientMock.APIModelRequest(MostPopular.self, path.absoluteString) { response in
            self.viewModel.results = response.results
            expectation.fulfill()
            
        } failure: { error in
            print("Error: \(error)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNotNil(mostPopularVM?.results)
        }
    }
    
    func testMockEmptyAPICalling1() {
        // Given
        let mostPopularVM = viewModel
        guard let path = bundle.url(forResource: "MostPopular", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Testing API Calling")
        
        HTTPClientMock.APIModelRequest(MostPopular.self, path.absoluteString) { response in
            expectation.fulfill()
            
        } failure: { error in
            print("Error: \(error)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNil(mostPopularVM?.results)
        }
    }
}
