//
//  FlickrConstants.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/14/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension FlickrClient {
    
    struct BaseConstants {
    
        static let Base_URL = "https://api/flickr.com/services/rest/"
        static let API_Key = ""
    }
    
    struct Methods {
    
        static let PhotoSearch = "flickr.photos.search"
    }
    
    struct Parameters {
    
        static let Extras = "url_m"
        static let Data_Format = "json"
        static let No_JSON_Callback = "1"
        static let Photos_Only = "1"
    }
    
    struct JSONKeys {
    
        static let Photo_Dicionary = "photos"
        static let Photo_Array = "photo"
        static let Photo_Title = "title"
        static let Photo_URL = "url_m"
        static let Photo_Count = "total"
        static let Photo_ID = "id"
        static let Photo_Pages = "pages"
    }
}