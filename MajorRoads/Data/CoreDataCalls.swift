//
//  CoreDataCalls.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataCalls {
    
    var managedContext:NSManagedObjectContext?
    static let sharedInstance: CoreDataCalls = CoreDataCalls()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getFavourites(completionHandler: @escaping (_ favouritIDs: [NSManagedObject]) -> Void) -> Void{
        var favourites: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        do {
            favourites = (try managedContext?.fetch(fetchRequest))!
            if favourites.count > 0 {
                completionHandler(favourites)
            } else {
                completionHandler([])
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completionHandler([])
        }
    }
    
    func addFavourite(id: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: managedContext!)!
        let favourite = NSManagedObject(entity: entity, insertInto: managedContext)
        let idNumber = id
        favourite.setValue(idNumber, forKeyPath: "id")
        do {
            try managedContext?.save()
            managedContext?.refreshAllObjects()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFavourite(id: String) {
        var favourites: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        do {
            favourites = (try managedContext?.fetch(fetchRequest))! // get favourite Ids from core data
            if favourites.count > 0 { // checks favourites exist
                if let favourite = favouriteExists(favourites: favourites, id: id) {
                    managedContext?.delete(favourite)
                    do {
                        try managedContext?.save()
                        managedContext?.refreshAllObjects()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    private func favouriteExists(favourites: [NSManagedObject], id: String) -> NSManagedObject? {
        for i in 0...(favourites.count - 1) {
            let favourite = (favourites as [NSManagedObject])[i]
            if favourite.value(forKey: "id")! as! String == id {
                return favourite
            }
        }
        return nil
    }
    
    
    
}
