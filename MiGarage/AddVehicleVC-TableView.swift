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
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
            
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.VehicleTextCell) as! UITableViewCell
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.AddVehicleNotesCell) as! UITableViewCell
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.AddVehicleCell) as! UITableViewCell
        }
        
        return setupTableCell(indexPath, cell: cell)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
