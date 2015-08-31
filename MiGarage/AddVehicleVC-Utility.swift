//
//  AddVehicleVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: AddVehicleMenuDelegate, NotesViewDelegate {
    
    enum AddVehicleCellPosition: Int {
        
        case Make = 0, Model, Year, Nickname, Notes
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
            }
            
        case AddVehicleCellPosition.Year.rawValue:
            cell.textLabel?.text = "Year"
            if vehicleData != nil {
                cell.detailTextLabel?.text = vehicleData?.year.stringValue
            } else {
                cell.detailTextLabel?.text = "Select"
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
    
    func setupMenuChoices(selection: Int) -> [String] {
        
        switch selection {
            
        case AddVehicleCellPosition.Make.rawValue:
            return ["Make 1", "Make 2", "Make 3", "Make 4", "Make 5"]
            
        case AddVehicleCellPosition.Model.rawValue:
            return ["Model 1", "Model 2", "Model 3"]
            
        case AddVehicleCellPosition.Year.rawValue:
            return ["2015", "2014", "2013", "2012", "2011", "2010", "2009"]
            
        default:
            return []
        }
    }
    
    func setupTitle(selection: Int) -> String? {
        
        switch selection {
            
        case AddVehicleCellPosition.Make.rawValue:
            return "Make"
            
        case AddVehicleCellPosition.Model.rawValue:
            return "Model"
            
        case AddVehicleCellPosition.Year.rawValue:
            return "Year"
            
        default:
            return nil
        }
    }
    
    func getNicknameValue() -> String? {
        
        let cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Nickname.rawValue, inSection: 0)) as! VehicleTextCell
        
        return cell.vehicleText.text
    }
    
    // MARK: - AddVehicleMenuDelegate
    
    func didSelectMenuItem(addVehicleMenu: AddVehicleMenuViewController, vehicleInfo: String, selection: String) {
        
        switch vehicleInfo {
            
        case "Make":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Make.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.make = selection
            
        case "Model":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Model.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.model = selection
            
        case "Year":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Year.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.year = selection.toInt()
            
        default:
            break
        }
    }
    
    // MARK: - NotesViewDelegate
    func didCompleteEditingNotes(notesView: AddVehicleTextViewController, newText: String?) {
        
        newVehicle?.notes = newText
    }
}
