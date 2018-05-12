//
//  ViewController.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, setupFavouriteButton, displayError, roadFound {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
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
            searchBar.isHidden = true
            title = ""
            roadFound(road: road)
        }
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for a road"
        self.definesPresentationContext = true
        
        modelController.errorDelegate = self
        modelController.setupFavouriteDelegate = self
        modelController.roadFoundDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = modelController.road?.name {
            modelController.requestRoadInfo(searchRoad: name)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil, let road = searchBar.text {
            clearView()
            modelController.requestRoadInfo(searchRoad: road)
        }
        searchBar.endEditing(true)
    }
    
    func clearView() {
        modelController.road = nil
        self.errorView.isHidden = true
        self.detailView.isHidden = true
    }
    
    func roadFound(road: Road) {
        self.errorView.isHidden = true
        self.detailView.isHidden = false
        let road = self.modelController.road
        if road != nil {
            self.displayName.text = road?.name
            self.statusSeverity.text = road?.severity
            self.statusSeverityDescription.text = road?.description
        }
        setupFavouriteButton()
    }
    
    func displayError(error:String){
        self.errorView.isHidden = false
        self.detailView.isHidden = true
        self.errorLabel.text = error
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

