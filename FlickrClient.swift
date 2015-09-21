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
    
    func searchByTags(searchTags: [String], inclusiveSearch: Bool, completionHandler: (success: Bool, data: [[String: AnyObject]]?, error: NSError?) -> Void) {
        
        let arguments = [
            
            SearchArguments.FlickrMethod: Methods.PhotoSearch,
            SearchArguments.FlickrAPI: BaseConstants.API_Key,
            SearchArguments.ContentType: Parameters.ContentType_Photos_Only,
            SearchArguments.GetExtraPhotoInfo: Parameters.Extras,
            SearchArguments.NoJSONCallback: Parameters.No_JSON_Callback,
            SearchArguments.ReturnDataFormat: Parameters.Data_Format,
            SearchArguments.SearchTags: "%2C+".join(searchTags),
            SearchArguments.SearchTagsMode: inclusiveSearch ? Parameters.SearchByTagsModeAll : Parameters.SearchByTagsModeAny
        ]
        
        let urlString = BaseConstants.Base_URL + MiGarageUtility.escapedParameters(arguments)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        //TODO: sendRequest
    }
}
