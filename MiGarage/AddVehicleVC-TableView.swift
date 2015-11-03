//
//  AddVehicleVC-TableView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum AddVehicleCellPosition: Int {
        
        case Make = 0, Model, Year, Engine, Transmission, Nickname, Notes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case AddVehicleCellPosition.Nickname.rawValue:
            let textCell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.VehicleTextCell)
            return setupTextCell(indexPath, cell: textCell!)
            
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.AddVehicleCell)
            return setupTableCell(indexPath, cell: cell!)
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
            
        case AddVehicleCellPosition.Notes.rawValue:
            performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.ShowNotesView, sender: indexPath.row)
            
        case AddVehicleCellPosition.Engine.rawValue:
            setupEngineTransMenus() {
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.AddVehicleMenu, sender: indexPath.row)
                }
            }
            
        default:
            performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.AddVehicleMenu, sender: indexPath.row)
        }
    }
    
    func setupTableCell(indexPath: NSIndexPath, cell: UITableViewCell) -> UITableViewCell {
        
        switch indexPath.row {
            
        case AddVehicleCellPosition.Make.rawValue:
            cell.textLabel?.text = "Make"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.make
            } else {
                cell.detailTextLabel?.text = "Select"
            }
            
        case AddVehicleCellPosition.Model.rawValue:
            cell.textLabel?.text = "Model"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.model
            } else {
                cell.detailTextLabel?.text = "Select"
                cell.hidden = true
            }
            
        case AddVehicleCellPosition.Year.rawValue:
            cell.textLabel?.text = "Year"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.year.stringValue
            } else {
                cell.detailTextLabel?.text = "Select"
                cell.hidden = true
            }
            
        case AddVehicleCellPosition.Engine.rawValue:
            cell.textLabel?.text = "Engine Type"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.engineType
            } else {
                cell.detailTextLabel?.text = "Select"
                cell.hidden = true
            }
            
        case AddVehicleCellPosition.Transmission.rawValue:
            cell.textLabel?.text = "Transmission"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.transmissionType
            } else {
                cell.detailTextLabel?.text = "Select"
                cell.hidden = true
            }
            
        case AddVehicleCellPosition.Notes.rawValue:
            cell.textLabel?.text = "Notes"
            cell.detailTextLabel?.text = "Edit"
            
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func setupTextCell(indexPath: NSIndexPath, cell: UITableViewCell) -> UITableViewCell {
        
        cell.textLabel?.text = "Nickname"
        if vehicleData != nil {
            
            cell.detailTextLabel?.text = vehicleData?.nickname
        }
        
        return cell
    }
}
