//
//  AddVehicleVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController {
    
    func setupTableCell(indexPath: NSIndexPath, cell: UITableViewCell) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            cell.textLabel?.text = "Make"
            cell.detailTextLabel?.text = "Select"
            
        case 1:
            cell.textLabel?.text = "Model"
            cell.detailTextLabel?.text = "Select"
            
        case 2:
            cell.textLabel?.text = "Year"
            cell.detailTextLabel?.text = "Select"
            
        case 3:
            cell.textLabel?.text = "Nickname"
            cell.detailTextLabel?.text = "Edit"
            
        case 4:
            cell.textLabel?.text = "Notes"
            cell.detailTextLabel?.text = "Edit"
            
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func setupMenuChoices(selection: Int) -> [String] {
        
        switch selection {
            
        case 0: // Make
            return ["Make 1", "Make 2", "Make 3", "Make 4", "Make 5"]
            
        case 1: // Model
            return ["Model 1", "Model 2", "Model 3"]
            
        case 2: // Year
            return ["2015", "2014", "2013", "2012", "2011", "2010", "2009"]
            
        default:
            return []
        }
    }
}
