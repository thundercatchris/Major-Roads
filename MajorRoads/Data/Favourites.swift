//
//  Favourites.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import CoreData

protocol favouritesUpdated {
    func favouritesUpdated()
}

class Favourites {
    
    var favouriteIds:[NSManagedObject]?
    var delegate:favouritesUpdated?
    
    static let sharedInstance: Favourites = Favourites()
    let coreData = CoreDataCalls.sharedInstance
    
    private init() {
        getIds()
    }
    
    func getIds() {
        coreData.getFavourites { (returnedIds) in
            self.favouriteIds = returnedIds
            self.delegate?.favouritesUpdated()
        }
    }
    
    
}
