//
//  NetworkRequest.swift
//  MajorRoadsTests
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import XCTest
@testable import MajorRoads

class NetworkRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsInvalidRoad() {
        let request = NetworkRequest()
        let road = "XXX"
        let expect = expectation(description: "Alamofire")
        request.roadStatusRequest(roads: road) { (array, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(array)
            expect.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIsValidRoad() {
        let request = NetworkRequest()
        let road = "A2"
        let expect = expectation(description: "Alamofire")
        request.roadStatusRequest(roads: road) { (array, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(array)
            XCTAssertEqual(array?.count, 1)
            expect.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMultipleRoads() {
        let request = NetworkRequest()
        let roads = "A2,A1"
        let expect = expectation(description: "Alamofire")
        request.roadStatusRequest(roads: roads) { (array, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(array)
            XCTAssertEqual(array?.count, 2)
            expect.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}
