//
//  Favourites.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import CoreData

let favouritesObserverKey = "com.thundercatchris.FavouritesUpdated"
let checkFavouriteObserverKey = "com.thundercatchris.checkFavourite"

class Favourites {
    
    var favouriteIds:[NSManagedObject]?
    
    static let sharedInstance: Favourites = Favourites()
    let coreData = CoreDataCalls.sharedInstance
    
    private init() {
        getIds()
    }
    
    func getIds() {
        coreData.getFavourites { (returnedIds) in
            self.favouriteIds = returnedIds
            let name = Notification.Name(favouritesObserverKey)
                NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    
}
