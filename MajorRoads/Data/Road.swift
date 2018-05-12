//
//  Road.swift
//  
//
//  Created by Cerebro on 12/05/2018.
//

import Foundation


class Road {

    let name: String
    let severity: String
    let description:String
    
    var isFavourite = false
    
    init(nameString:String, severityString:String, descriptionString:String) {
        name = nameString
        severity = severityString
        description = descriptionString
    }

}
