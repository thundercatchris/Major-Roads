//
//  RoadDetailViewController.swift
//  MajorRoads
//
//  Created by Cerebro on 13/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import UIKit

class RoadDetailViewController: UIViewController, roadFound {
    
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var statusSeverity: UILabel!
    @IBOutlet weak var statusSeverityDescription: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    let modelController = SearchViewModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // when selecting a favourite from the table, this view is reused starting with an existing road object
        if let road = modelController.road {
            roadFound(road: road)
        }
        let name = Notification.Name(checkFavouriteObserverKey)
        NotificationCenter.default.addObserver(self, selector: #selector(favouritesChanged(notification:)), name: name, object: nil)
    }
    
    func roadFound(road: Road) {
        DispatchQueue.main.async {
            let road = self.modelController.road
            if road != nil {
                self.displayName.text = road?.name
                self.statusSeverity.text = road?.severity
                self.statusSeverityDescription.text = road?.description
            }
        }
        setupFavouriteButton()
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func favouritesChanged(notification: NSNotification) {
        if let info = notification.userInfo {
            for (_,value) in info {
                if (value as? String) == modelController.road?.name {
                    modelController.road?.isFavourite = !(modelController.road?.isFavourite)!
                    setupFavouriteButton()
                }
            }
        }
    }
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        modelController.favouritePressed()
    }
    
    func  setupFavouriteButton() {
        DispatchQueue.main.async() {
            self.favouriteButton.imageView?.image = (self.modelController.road?.isFavourite)! ? UIImage(named: "favouriteSelected") : UIImage(named: "favourite")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

