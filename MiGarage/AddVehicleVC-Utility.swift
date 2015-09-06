//
//  AddVehicleVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: AddVehicleMenuDelegate, NotesViewDelegate {
    
    func setupMenuChoices(selection: Int) -> [String] {
        
        switch selection {
            
        case AddVehicleCellPosition.Make.rawValue:
            return getMakesMenu()
            
        case AddVehicleCellPosition.Model.rawValue:
            return getModelsMenu()
            
        case AddVehicleCellPosition.Year.rawValue:
            return ["2015", "2014", "2013", "2012", "2011", "2010", "2009"]
            
        default:
            return []
        }
    }
    
    func getMakesMenu() -> [String] {
            
        var menuChoices = [String]()
        
        if edmundsData != nil {
            
            for edmundsItem: [String: AnyObject] in edmundsData! {
                
                let name = edmundsItem[EdmundsClient.JSONKeys.Name] as! String
                menuChoices.append(name)
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            menuChoices = []
        }
        
        return menuChoices
    }
    
    func getModelsMenu() -> [String] {
        
        var menuChoices = [String]()
        
        if edmundsData != nil {
            
            for edmundsItem: [String: AnyObject] in edmundsData! {
                
                let makeName = edmundsItem[EdmundsClient.JSONKeys.Name] as! String
                if makeName == newVehicle?.make {
                    
                    let modelList = edmundsItem[EdmundsClient.JSONKeys.Models_Array] as! [[String: AnyObject]]
                    for modelItem: [String: AnyObject] in modelList {
                        
                        let modelName = modelItem[EdmundsClient.JSONKeys.Name] as! String
                        menuChoices.append(modelName)
                    }
                    
                    break
                }
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            menuChoices = []
        }
        
        return menuChoices
    }
    
    func getYearMenu() -> [String] {
        
        var menuChoices = [String]()
        
        if edmundsData != nil {
            
            for edmundsItem: [String: AnyObject] in edmundsData! {
                
                let makeName = edmundsItem[EdmundsClient.JSONKeys.Name] as! String
                if makeName == newVehicle?.make {
                    
                    let modelList = edmundsItem[EdmundsClient.JSONKeys.Models_Array] as! [[String: AnyObject]]
                    for modelItem: [String: AnyObject] in modelList {
                        
                        let modelName = modelItem[EdmundsClient.JSONKeys.Name] as! String
                        if modelName == newVehicle?.model {
                            
                            let yearList = modelItem[EdmundsClient.JSONKeys.Years_Array] as! [[String: AnyObject]]
                            for yearItem: [String: AnyObject] in yearList {
                                
                                let yearName = yearItem[EdmundsClient.JSONKeys.Years_Name] as! String
                                menuChoices.append(yearName)
                            }
                            
                            break
                        }
                    }
                }
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            menuChoices = []
        }
        
        return menuChoices
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
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Model.rawValue, inSection: 0))!
            nextCell.hidden = false
            
        case "Model":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Model.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.model = selection
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Year.rawValue, inSection: 0))!
            nextCell.hidden = false
            
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
