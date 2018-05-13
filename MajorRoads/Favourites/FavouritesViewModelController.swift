//
//  FavouritesViewModelController.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

protocol reloadTable {
    func reloadTable()
}


class FavouritesViewModelController {
    
    
    let favourite = Favourites.sharedInstance
    var roads:[Road] = []
    var delegateReload:reloadTable?
    var delegateError:displayError?
    
    func getFavourites() {
        roads.removeAll()
        
        let existingRoads = roadString()
        if existingRoads.count != 0 {
            requestRoadInfo(searchRoad: existingRoads)
        }
        self.delegateReload?.reloadTable()
    }
    
    func requestRoadInfo(searchRoad:String) {
        NetworkRequest().roadStatusRequest(roads: searchRoad) { (array, error)  in
            if let error = error {
                self.delegateError?.displayError(error: error)
            } else if let array = array {
                self.appendRoadsFromArray(array: array)
                self.delegateReload?.reloadTable()
            }
        }
    }
    
    func appendRoadsFromArray(array: NSArray) {
        let endOfArray = (array.count - 1)
        for i in 0...endOfArray {
            if let dict = array[i] as? NSDictionary, let road = RoadHelper().roadFromDict(dict: dict) {
                self.roads.append(road)
            }
        }
    }
    
    func roadString() -> String {
        var roadsString = ""
        if let ids = favourite.favouriteIds, ids.count > 0 {
            for i in 0...(ids.count - 1) {
                let item = favourite.favouriteIds![i]
                if let id = item.value(forKey: "id") as? String {
                    roadsString += roadStringIdFormat(index: i, id: id)
                }
            }
        }
        return roadsString
    }
    
    func roadStringIdFormat(index: Int, id:String) -> String {
        return (index == 0) ? "\(id)" : ",\(id)"
    }
    
}
