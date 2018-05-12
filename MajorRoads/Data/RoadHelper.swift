//
//  RoadHelper.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

class RoadHelper {
    
    func roadFromDict(dict:NSDictionary) -> Road? {
        if let name = dict["displayName"] as? String, let severity = dict["statusSeverity"] as? String, let description = dict["statusSeverityDescription"] as? String {
            let road = Road(nameString: name, severityString: severity, descriptionString: description)
            road.isFavourite = true
            return Road(nameString: name, severityString: severity, descriptionString: description)
        }
        return nil
    }
       
}
