//
//  AddVehicleMenuVC-TableView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleMenuViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.AddVehicleMenuCell) as! UITableViewCell
        if sortedChoices == nil {
            return cell
        }
        
        cell.textLabel?.text = sortedChoices![indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedChoices!.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let selectItem = sortedChoices![indexPath.row]
        delegate?.didSelectMenuItem(self, vehicleInfo: title!, selection: selectItem, details: menuChoices![selectItem]!)
    }
}
