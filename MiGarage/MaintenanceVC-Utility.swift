//
//  MaintenanceVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 10/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension MaintenanceViewController {
    
    func loadMaintenanceData() {
        
        EdmundsClient.sharedInstance().getMaintenanceScheduleByVehicle(vehicleInfo!.modelYearID) {
            
            success, data, error in
            
            if success {
                
                if let maintData = data {
                    
                    for itemData in maintData {
                        
                        let itemID = itemData[EdmundsClient.JSONKeys.ID] as! Int
                        let engineCode = itemData[EdmundsClient.JSONKeys.MaintenanceItem_Engine] as! String
                        let transCode = itemData[EdmundsClient.JSONKeys.MaintenanceItem_Transmission] as! String
                        let mileage = itemData[EdmundsClient.JSONKeys.MaintenanceItem_IntMileage] as! Int
                        let action = itemData[EdmundsClient.JSONKeys.MaintenanceItem_Action] as! String
                        let itemName = itemData[EdmundsClient.JSONKeys.MaintenanceItem_Item] as! String
                        let description = itemData[EdmundsClient.JSONKeys.MaintenanceItem_Description] as! String
                        
                        self.vehicleInfo?.addMaintenanceItem(itemID, engineCode: engineCode, transmission: transCode, mileage: mileage, action: action, itemName: itemName, itemDescription: description)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.loadingView.fallAnimation(0.25, hideOnCompletion: true, completionHandler: nil)
                    self.grayoutBackground.fadeOut(0.25, hideOnCompletion: true, completionHandler: nil)
                    do {
                        try self.fetchedResultsController.performFetch()
                    } catch _ {
                    }
                    self.maintenanceTable.reloadData()
                }
            } else {
                
                print("\(error): \(error?.userInfo)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let alert = UIAlertView(title: "Error", message: "Whoops! There was an error retrieving the data from Edmunds.com. Please try again.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
}