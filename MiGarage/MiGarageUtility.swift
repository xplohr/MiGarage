//
//  MiGarageUtility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class MiGarageUtility {
    
    struct ReuseIdentifiers {
    
        static let VehicleCell = "vehicleCell"
        static let VehicleTextCell = "vehicleTextCell"
        static let AddVehicleCell = "vehicleInfoCell"
        static let AddVehicleMenuCell = "addVehicleMenuCell"
        static let VehiclePhotoCell = "vehiclePhotoCell"
        static let FlickrPhotoCell = "flickrPhotoCell"
        static let MaintenanceCell = "maintenanceCell"
    }
    
    struct SegueIdentifiers {
    
        static let VehicleDetails = "showVehicleDetails"
        static let AddVehicleMenu = "showAddVehicleMenu"
        static let AddVehicleText = "showAddVehicleText"
        static let AddVehicleSelectedMenu = "selectedAddVehicleMenuItem"
        static let ShowNotesView = "showNotesField"
        static let VehicleDash = "showVehicleDashboard"
        static let PhotoGallery = "showPhotoGallery"
        static let FlickrGallery = "showFlickrGallery"
        static let PhotoDetail = "showPhotoDetail"
        static let showVehiclePhotoGallery = "showVehiclePhotoGallery"
        static let MaintenanceSchedule = "showMaintenanceSchedule"
        static let DetailNotes = "ShowNotesFromDetail"
    }
    
    /* Helper: Given a dictionary of parameters, convert to a String for a URL */
    class func escapedParameters(parameters: [String: AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let replaceSpaceValue = escapedValue!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            urlVars += [key + "=" + "\(replaceSpaceValue)"]
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    /* Helper: Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsingError: NSError? = nil
        let parsedResult: AnyObject?
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        } catch let error as NSError {
            parsingError = error
            parsedResult = nil
        }
        
        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult, error: nil)
        }
    }
    
    /* Helper: Substitute the placeholder in the method name with an actual value */
    class func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
        
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    // Helper: Display an alert view with an error message
    class func showErrorAlert(title: String, message: String) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        })
    }
}