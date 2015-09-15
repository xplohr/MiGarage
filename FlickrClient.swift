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
}
