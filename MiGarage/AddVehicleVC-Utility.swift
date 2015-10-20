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
            
        case AddVehicleCellPosition.Engine.rawValue:
            return engineData
            
        case AddVehicleCellPosition.Transmission.rawValue:
            return transmissionData
            
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
    
    func setupEngineTransMenus(completionHandler: () -> Void) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.grayoutBackground.resetOpacity()
            self.grayoutBackground.hidden = false
            self.loadingView.resetFallAnimation()
            self.loadingView.animate()
            self.loadingBackground.rotate360Degrees(repeatCount: 30.0)
        }
        
        let vehicleInfo = [
        
            EdmundsClient.JSONKeys.Makes_Array: newVehicle!.makeNicename!,
            EdmundsClient.JSONKeys.Models_Array: newVehicle!.modelNicename!,
            EdmundsClient.JSONKeys.Years_Array: newVehicle!.year!.stringValue
        ]
        
        EdmundsClient.sharedInstance().getEdmundsEngineTransDataForMenus(vehicleInfo) {
            
            success, data, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.loadingView.fallAnimation(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
                self.grayoutBackground.fadeOut(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
            }
            
            if success {
                
                if data != nil {
                    
                    let styles: [[String: AnyObject]] = data!
                    for style: [String: AnyObject] in styles {
                        
                        let engineData = style[EdmundsClient.JSONKeys.Engine_Array] as! [String: AnyObject]
                        let engineCode = engineData[EdmundsClient.JSONKeys.Engine_Code] as! String
                        let engineSize = engineData[EdmundsClient.JSONKeys.Engine_Size] as! Double
                        let engineCyl = engineData[EdmundsClient.JSONKeys.Engine_Cylinders] as! Int
                        let engineFuel = engineData[EdmundsClient.JSONKeys.Engine_FuelType] as! String
                        
                        let engineMenuItem = "\(engineSize)L \(engineCyl) cyl \(engineFuel)"
                        
                        if let engineKey = self.engineData[engineMenuItem] {
                            // Key exists, do nothing
                        } else {
                            
                            self.engineData[engineMenuItem] = [EdmundsClient.JSONKeys.Engine_Code: engineCode]
                        }
                        
                        let transData = style[EdmundsClient.JSONKeys.Transmission_Array] as! [String: AnyObject]
                        let transCode = transData[EdmundsClient.JSONKeys.Transmission_Type] as! String
                        let transGears = transData[EdmundsClient.JSONKeys.Transmission_Gears] as! String
                        
                        let transmissionMenuItem = "\(transGears) speed \(transCode)"
                        
                        if let transKey = self.transmissionData[transmissionMenuItem] {
                            // Key exists, do nothing
                        } else {
                            
                            self.transmissionData[transmissionMenuItem] = [EdmundsClient.JSONKeys.Transmission_Type: transCode]
                        }
                    }
                }
                
                completionHandler()
            } else {
                
                println("\(error): \(error?.userInfo)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let alert = UIAlertController(title: "Error", message: "Whoops! There was an error retireving the data from Edmunds.com. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    let okButton = UIAlertAction(title: "OK", style: .Default) {
                        (_) in
                    }
                    alert.addAction(okButton)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
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
            
        case AddVehicleCellPosition.Engine.rawValue:
            return "Engine Type"
            
        case AddVehicleCellPosition.Transmission.rawValue:
            return "Transmission"
            
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
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Engine.rawValue, inSection: 0))!
            nextCell.hidden = false
            
        case "Engine Type":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Engine.rawValue, inSection: 0))
            cell?.detailTextLabel?.text = selection
            newVehicle?.engineType = selection
            newVehicle?.engineCode = details[EdmundsClient.JSONKeys.Engine_Code] as? String
            
            let nextCell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Transmission.rawValue, inSection: 0))!
            nextCell.hidden = false
            
        case "Transmission":
            var cell = vehicleTable.cellForRowAtIndexPath(NSIndexPath(forItem: AddVehicleCellPosition.Transmission.rawValue, inSection: 0))
            cell?.detailTextLabel?.text = selection
            newVehicle?.transType = selection
            newVehicle?.transCode = details[EdmundsClient.JSONKeys.Transmission_Type] as? String
            
        default:
            break
        }
    }
    
    // MARK: - NotesViewDelegate
    func didCompleteEditingNotes(notesView: AddVehicleTextViewController, newText: String?) {
        
        newVehicle?.notes = newText
    }
}
