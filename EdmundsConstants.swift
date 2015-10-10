//
//  EdmundsConstants.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/31/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

extension EdmundsClient {
    
    struct Constants {
    
        static let Base_URL = "https://api.edmunds.com/api/vehicle/v2/"
        static let API_Key = "q2qy5bz6zz7xh5fbbcfcdzbc"
    }
    
    struct Methods {
    
        static let GetMakes = "makes"
        static let GetStyles = "styles"
    }
    
    struct Keys {
    
        static let DataView = "view"
        static let DataFormat = "fmt"
        static let APIKey = "api_key"
    }
    
    struct JSONKeys {
    
        static let Makes_Array = "makes"
        static let Name = "name"
        static let Models_Array = "models"
        static let Years_Array = "years"
        static let Years_Name = "year"
        static let Nicename = "niceName"
        static let ID = "id"
        static let Styles_Array = "styles"
        static let Engine_Array = "engine"
        static let Engine_Size = "size"
        static let Engine_Cylinders = "cylinder"
        static let Engine_FuelType = "type"
        static let Engine_Code = "code"
        static let Transmission_Array = "transmission"
        static let Transmission_Type = "transmissionType"
        static let Transmission_Gears = "numberOfSpeeds"
    }
}
