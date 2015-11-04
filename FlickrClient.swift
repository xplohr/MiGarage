//
//  FlickrClient.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/14/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class FlickrClient: NSObject {
    
    class func sharedInstance() -> FlickrClient {
        
        struct Singleton {
            
            static var sharedInstance = FlickrClient()
        }
        
        return Singleton.sharedInstance
    }
    
    func searchByTags(searchTags: [String], inclusiveSearch: Bool, completionHandler: (data: [[String: AnyObject]]?, error: NSError?) -> Void) {
        
        let arguments = [
            
            SearchArguments.FlickrMethod: Methods.PhotoSearch,
            SearchArguments.FlickrAPI: BaseConstants.API_Key,
            SearchArguments.ContentType: Parameters.ContentType_Photos_Only,
            SearchArguments.GetExtraPhotoInfo: Parameters.Extras,
            SearchArguments.NoJSONCallback: Parameters.No_JSON_Callback,
            SearchArguments.ReturnDataFormat: Parameters.Data_Format,
            SearchArguments.SearchTagsMode: inclusiveSearch ? Parameters.SearchByTagsModeAll : Parameters.SearchByTagsModeAny
        ]
        
        let urlString = BaseConstants.Base_URL + MiGarageUtility.escapedParameters(arguments) + makeTagString(searchTags)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        sendRequest(request) {
            data, error in
            
            completionHandler(data: data, error: error)
        }
    }
    
    func makeTagString(tags: [String]) -> String {
        
        var tagString = String()
        
        for tag: String in tags {
            
            tagString += "%2C+"
            let escapedValue = tag.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            let replaceSpaceValue = tag.stringByReplacingOccurrencesOfString(" ", withString: "%2C+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            tagString += replaceSpaceValue
        }
        
        return "&\(SearchArguments.SearchTags)=\(tagString)"
    }
    
    func sendRequest(request: NSURLRequest, completionHandler: (data: [[String: AnyObject]]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if let downloadError = error {
                
                print("Could not complete the Flickr request: \(downloadError)", terminator: "")
                completionHandler(data: nil, error: downloadError)
            } else {
                
                var parsingError: NSError? = nil
                let parsedResults: AnyObject?
                do {
                    parsedResults = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                } catch let error as NSError {
                    parsingError = error
                    parsedResults = nil
                } catch {
                    fatalError()
                }
                
                if let photosDictionary = parsedResults?.valueForKey(JSONKeys.Photo_Dicionary) as? NSDictionary {
                    
                    if let photoArray = photosDictionary.valueForKey(JSONKeys.Photo_Array) as? [[String: AnyObject]] {
                        
                        completionHandler(data: photoArray, error: parsingError)
                    } else {
                        
                        completionHandler(data: nil, error: NSError(domain: MiGarageError.Domain, code: MiGarageError.ErrorCodes.FlickrArrayError, userInfo: [MiGarageError.UserInfoKeys.Description: "There was a problem retrieving the photos array from Flickr."]))
                    }
                } else {
                    
                    completionHandler(data: nil, error: NSError(domain: MiGarageError.Domain, code: MiGarageError.ErrorCodes.FlickrDictionaryError, userInfo: [MiGarageError.UserInfoKeys.Description: "There was a problem retrieving the photos dictionary from Flickr."]))
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
        
        task.resume()
    }
}
