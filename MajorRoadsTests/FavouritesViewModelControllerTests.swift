//
//  FavouritesViewModelControllerTests.swift
//  MajorRoadsTests
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import XCTest
@testable import MajorRoads

class FavouritesViewModelControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIDStringFormat() {
        let request = FavouritesViewModelController()
        let road = "A2"
        let index = 1
        XCTAssertEqual(request.roadStringIdFormat(index: index, id: road), ",A2")
    }
    
    func testIDStringFormatFail() {
        let request = FavouritesViewModelController()
        let road = "A2"
        let index = 0
        XCTAssertNotEqual(request.roadStringIdFormat(index: index, id: road), ",A2")
    }
    
}
