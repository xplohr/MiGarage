//
//  AddVehicleVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: AddVehicleMenuDelegate, NotesViewDelegate {
    
    func setupMenuChoices(selection: Int) -> [String: [String: AnyObject]]? {
        
        switch selection {
            
        case AddVehicleCellPosition.Make.rawValue:
            return getMakesMenu()
            
        case AddVehicleCellPosition.Model.rawValue:
            return getModelsMenu()
            
        case AddVehicleCellPosition.Year.rawValue:
            return getYearMenu()
            
        default:
            return nil
        }
    }
    
    func getMakesMenu() -> [String: [String: AnyObject]]? {
            
        var menuChoices = [String: [String: AnyObject]]()
        
        if edmundsData != nil {
            
            for edmundsItem: [String: AnyObject] in edmundsData! {
                
                let name = edmundsItem[EdmundsClient.JSONKeys.Name] as! String
                let nicename = edmundsItem[EdmundsClient.JSONKeys.Nicename] as! String
                menuChoices[name] = [EdmundsClient.JSONKeys.Nicename: nicename]
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return nil
        }
        
        return menuChoices
    }
    
    func getModelsMenu() -> [String: [String:AnyObject]]? {
        
        var menuChoices = [String: [String: AnyObject]]()
        
        if edmundsData != nil {
            
            for edmundsItem: [String: AnyObject] in edmundsData! {
                
                let makeName = edmundsItem[EdmundsClient.JSONKeys.Name] as! String
                if makeName == newVehicle?.make {
                    
                    let modelList = edmundsItem[EdmundsClient.JSONKeys.Models_Array] as! [[String: AnyObject]]
                    for modelItem: [String: AnyObject] in modelList {
                        
                        let modelName = modelItem[EdmundsClient.JSONKeys.Name] as! String
                        let modelNicename = modelItem[EdmundsClient.JSONKeys.Nicename] as! String
                        menuChoices[modelName] = [EdmundsClient.JSONKeys.Nicename: modelNicename]
                    }
                    
                    break
                }
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return nil
        }
        
        return menuChoices
    }
    
    func getYearMenu() -> [String: [String: AnyObject]]? {
        
        var menuChoices = [String: [String: AnyObject]]()
        
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
                                
                                let yearName = yearItem[EdmundsClient.JSONKeys.Years_Name] as! NSNumber
                                let modelYearID = yearItem[EdmundsClient.JSONKeys.ID] as! NSNumber
                                menuChoices[yearName.stringValue] = [EdmundsClient.JSONKeys.ID: modelYearID.stringValue]
                            }
                            
                            break
                        }
                    }
                }
            }
        } else {
            
            let alert = UIAlertView(title: "Missing Data", message: "Sorry! We don't seem to have the proper data. Please try again.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return nil
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
    
    func didSelectMenuItem(addVehicleMenu: AddVehicleMenuViewController, vehicleInfo: String, selection: String, details: [String: AnyObject]) {
        
        switch vehicleInfo {
            
        case "Make":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Make.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.make = selection
            newVehicle?.makeNicename = details[EdmundsClient.JSONKeys.Nicename] as? String
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Model.rawValue, inSection: 0))!
            nextCell.hidden = false
            
        case "Model":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Model.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.model = selection
            newVehicle?.modelNicename = details[EdmundsClient.JSONKeys.Nicename] as? String
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Year.rawValue, inSection: 0))!
            nextCell.hidden = false
            
        case "Year":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Year.rawValue, inSection: 0))!
            cell.detailTextLabel?.text = selection
            newVehicle?.year = selection.toInt()
            newVehicle?.modelYearID = details[EdmundsClient.JSONKeys.ID] as? String
            
        default:
            break
        }
    }
    
    // MARK: - NotesViewDelegate
    func didCompleteEditingNotes(notesView: AddVehicleTextViewController, newText: String?) {
        
        newVehicle?.notes = newText
    }
}
