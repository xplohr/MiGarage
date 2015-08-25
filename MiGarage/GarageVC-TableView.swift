//
//  GarageVC-TableView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension GarageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = MiGarageUtility.ReuseIdentifiers.VehicleCell
        let vehicle = fetchedResultsController.fetchedObjects![indexPath.row] as! Vehicle
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! VehicleListCell
        
        cell.nameLabel.text = vehicle.nameForLabel
        cell.makeModelLabel.text = vehicle.modelForLabel
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Show vehicle details
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
}
