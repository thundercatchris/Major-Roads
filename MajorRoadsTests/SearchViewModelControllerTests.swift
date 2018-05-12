//
//  SearchViewModelControllerTests.swift
//  MajorRoadsTests
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import XCTest
@testable import MajorRoads

class SearchViewModelControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDictToRoad() {
        let dict = ["id":"a12","statusSeverity":"Good","statusSeverityDescription":"No Exceptional Delays","$type":"Tfl.Api.Presentation.Entities.RoadCorridor, Tfl.Api.Presentation.Entities","displayName":"A12","bounds":"[[-0.07183,51.51187],[0.28532,51.60844]]","envelope":"[[-0.07183,51.51187],[-0.07183,51.60844],[0.28532,51.60844],[0.28532,51.51187]","url":"/Road/a12"] as NSDictionary
        let helper = RoadHelper()
        let dictRoad = helper.roadFromDict(dict: dict)!
        let road = Road(nameString: "A12", severityString: "Good", descriptionString: "No Exceptional Delays")
        XCTAssertEqual(dictRoad.name, road.name)
        XCTAssertEqual(dictRoad.description, road.description)
        XCTAssertEqual(dictRoad.severity, road.severity)
    }
}
