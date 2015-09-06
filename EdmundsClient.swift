//
//  EdmundsClient.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/31/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class EdmundsClient: NSObject {
    
    class func sharedInstance() -> EdmundsClient {
    
        struct Singleton {
            
            static var sharedInstance = EdmundsClient()
        }
        
        return Singleton.sharedInstance
    }
    
    func sendRequest(request: NSURLRequest, completionHandler: (success: Bool, data: [[String: AnyObject]]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            data, response, downloadError in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if let error = downloadError {
                
                println("Could not complete the request: \(error)")
                completionHandler(success: false, data: nil, error: error)
            } else {
                
                var parsingError: NSError?
                let parsedResults: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                
                if let makesDictionary = parsedResults.valueForKey(JSONKeys.Makes_Array) as? [[String: AnyObject]] {
                    
                    completionHandler(success: true, data: makesDictionary, error: nil)
                } else {
                    
                    completionHandler(success: false, data: nil, error: NSError(domain: MiGarageError.Domain, code: MiGarageError.ErrorCodes.EdmundsMakesDictionaryError, userInfo: [MiGarageError.UserInfoKeys.Description: "There was a problem retrieving the makes dictionary from Edmunds.com."]))
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
        
        task.resume()
    }
    
    func getEdmundsDataForMenus(completionHandler: (success: Bool, data: [[String: AnyObject]]?, error: NSError?) -> Void) {
        
        let arguments = [
            
            Keys.DataView: "basic",
            Keys.DataFormat: "json",
            Keys.APIKey: Constants.API_Key
        ]
        
        let urlString = Constants.Base_URL + Methods.GetMakes + MiGarageUtility.escapedParameters(arguments)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        sendRequest(request) {
            
            success, data, error in
            
            completionHandler(success: success, data: data, error: error)
        }
    }
}
