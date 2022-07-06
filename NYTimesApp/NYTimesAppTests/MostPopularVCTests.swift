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
    
    func testOutletNotNil() {
        XCTAssertNotNil(mostPopularVC.tableView, "UITableView is nil")
    }
    
    func testTableViewDelegateNotNil() {
        XCTAssertNotNil(mostPopularVC.tableView.delegate, "UITableView Delegate is nil")
    }
    
    func testTableViewDatasourceNotNil() {
        XCTAssertNotNil(mostPopularVC.tableView.dataSource, "UITableView Datasource is nil")
    }
    
    func testMostPopularAPICalling() {
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
            XCTAssertEqual(mostPopularVM?.results?.count, 20)
            XCTAssertNotNil(mostPopularVM?.results?.first)
        }
    }
    
    func testMockMostPopularAPICalling() {
        // Given
        let mostPopularVM = viewModel
        guard let path = bundle.url(forResource: "MostPopular", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Testing Most Popular API Calling")
        
        // When
        NetworkManagerMock.apiModelRequest(MostPopular.self, path.absoluteString) { response in
            self.viewModel.results = response.results
            expectation.fulfill()
            
        } failure: { error in
            print("Error: \(error)")
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 20) { error in
            XCTAssertNotNil(mostPopularVM?.results)
            XCTAssertEqual(mostPopularVM?.results?.count, 20)
            XCTAssertNotNil(mostPopularVM?.results?.first)
            
            XCTAssertEqual(mostPopularVM?.results?.first?.title, "Biden Takes Tumble During Bike Ride in Delaware")
            XCTAssertEqual(mostPopularVM?.results?.first?.byline, "By Zach Montague")
            XCTAssertEqual(mostPopularVM?.results?.first?.source, "New York Times")
            XCTAssertEqual(mostPopularVM?.results?.first?.publishedDate, "2022-06-18")
        }
    }
}

//
