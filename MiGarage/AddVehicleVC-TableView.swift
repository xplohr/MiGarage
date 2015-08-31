//
//  AddVehicleVC-TableView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case AddVehicleCellPosition.Nickname.rawValue:
            let textCell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.VehicleTextCell) as! UITableViewCell
            return setupTextCell(indexPath, cell: textCell)
            
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.AddVehicleCell) as! UITableViewCell
            return setupTableCell(indexPath, cell: cell)
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
            
        case AddVehicleCellPosition.Notes.rawValue:
            performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.ShowNotesView, sender: indexPath.row)
            
        default:
            performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.AddVehicleMenu, sender: indexPath.row)
        }
    }
}
