//
//  SearchViewModelController.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

protocol displayError {
    func displayError(error:String)
}

protocol roadFound {
    func roadFound(road:Road)
}

protocol setupFavouriteButton {
    func setupFavouriteButton()
}

class SearchViewModelController {
    let coreData = CoreDataCalls.sharedInstance
    let favourite = Favourites.sharedInstance
    var errorDelegate:displayError?
    var roadFoundDelegate:roadFound?
    var setupFavouriteDelegate:setupFavouriteButton?
    
    var road: Road?
    
    func requestRoadInfo(searchRoad:String) {
        NetworkRequest().roadStatusRequest(roads: searchRoad) { (array, error)  in
            if error != nil {
                if let error = error {
                    self.errorDelegate?.displayError(error: error)
                }
            } else if array != nil {
                if let dict = array![0] as? NSDictionary, let road = RoadHelper().roadFromDict(dict: dict) {
                    self.road = road
                    self.getFavourites()
                }
            }
        }
    }
    
    func getFavourites() {
        if (favourite.favouriteIds?.count)! > 0 {
            for i in 0...((favourite.favouriteIds?.count)! - 1) {
                let item = favourite.favouriteIds![i]
                if let id = item.value(forKey: "id") as? String {
                    if id == road?.name {
                        road?.isFavourite = true
                        break
                    }
                }
            }
        }
        self.roadFoundDelegate?.roadFound(road: road!)
    }
    
    func favouritePressed() {
        if let id = road?.name, let isFavourite = road?.isFavourite {
            if !isFavourite {
                coreData.addFavourite(id: id)
            } else {
                coreData.deleteFavourite(id: id)
            }
            favourite.getIds()
            road?.isFavourite = !(road?.isFavourite)!
            setupFavouriteDelegate?.setupFavouriteButton()
        }
    }
    
}
