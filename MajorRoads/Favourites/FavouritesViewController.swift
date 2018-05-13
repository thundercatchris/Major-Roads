//
//  FavouritesViewController.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, reloadTable, displayError, favouritesUpdated {
    
    let modelController = FavouritesViewModelController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        modelController.delegateReload = self
        modelController.delegateError = self
        
        modelController.getFavourites()
        modelController.favourite.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.roads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoadTableViewCell", for: indexPath) as! RoadTableViewCell
        cell.prepareForReuse()
        cell.road = modelController.roads[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let nextScene = segue.destination as? SearchViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let road = modelController.roads[indexPath.row]
            nextScene.modelController.road = road
        }
    }
    
    func favouritesUpdated() {
        modelController.getFavourites()
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: error, message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated:true, completion: nil)
    }
    
}
