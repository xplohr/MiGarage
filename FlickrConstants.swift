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
    
        static let Base_URL = "https://api.flickr.com/services/rest/"
        static let API_Key = "ac5134605ce4cd756c025913ed792ba1"
    }
    
    struct Methods {
    
        static let PhotoSearch = "flickr.photos.search"
    }
    
    struct SearchArguments {
    
        static let GetExtraPhotoInfo = "extras"
        static let ReturnDataFormat = "format"
        static let SearchTags = "tags"
        static let SearchTagsMode = "tag_mode"
        static let FlickrMethod = "method"
        static let FlickrAPI = "api_key"
        static let ContentType = "content_type"
        static let NoJSONCallback = "nojsoncallback"
    }
    
    struct Parameters {
    
        static let Extras = "url_m"
        static let Data_Format = "json"
        static let No_JSON_Callback = "1"
        static let ContentType_Photos_Only = "1"
        static let SearchByTagsModeAll = "all"
        static let SearchByTagsModeAny = "any"
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