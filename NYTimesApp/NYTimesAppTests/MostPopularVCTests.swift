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
    let mockMostResult = MostResults(uri: "", url: "", id: 100000008405898, assetID: 100000008405898, source: "New York Times", publishedDate: "2022-06-18", updated: "2022-06-19 12:23:25", section: "U.S.", subsection: "Politics", nytdsection: "u.s.", adxKeywords: "Bicycles and Bicycling;Falls;United States Politics and Government;Biden, Joseph R Jr;Rehoboth Beach (Del)", column: "", byline: "By Zach Montague", type: "Article", title: "Biden Takes Tumble During Bike Ride in Delaware", abstract: "The president did not need medical attention after he fell off his bike at a state park near his vacation home in Rehoboth Beach, according to the White House.", desFacet: ["Bicycles and Bicycling", "Falls", "United States Politics and Government"], orgFacet: [], perFacet: [], geoFacet: [], media: nil, etaID: 0)
    
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
    
    func test_OutletNil() {
        XCTAssertNotNil(mostPopularVC.tableView, "UITableView is nil")
    }
    
    func test_APICalling() {
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
    
    func testMock_DataAPICalling1() {
        // Given
        let mostPopularVM = viewModel
        guard let path = bundle.url(forResource: "MostPopular", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Testing API Calling")
        
        // When
        NetworkManagerMock.apiModelRequest(MostPopular.self, path.absoluteString) { response in
            // Then
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
    
    func testMock_EmptyAPICalling1() {
        // Given
        let mostPopularVM = viewModel
        guard let path = bundle.url(forResource: "MostPopular", withExtension: "json") else { return }
        let expectation = self.expectation(description: "Testing API Calling")
        
        // When
        NetworkManagerMock.apiModelRequest(MostPopular.self, path.absoluteString) { response in
            // Then
            expectation.fulfill()
            
        } failure: { error in
            print("Error: \(error)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            XCTAssertNil(mostPopularVM?.results)
        }
    }
    
    func test_ModelMostPopular_Title() {
        let mockMostTitle = mockMostResult.title
        
        XCTAssertNotNil(mockMostTitle)
    }
    
    func test_ModelMostPopular_ByLine() {
        let mockMostByLine = mockMostResult.byline
        
        XCTAssertNotNil(mockMostByLine)
    }
    
    func test_ModelMostPopular_Source() {
        let mockMostSource = mockMostResult.source
        
        XCTAssertNotNil(mockMostSource)
    }
}

