//
//  EdmundsConstants.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/31/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

extension EdmundsClient {
    
    struct Constants {
    
        static let Base_URL = "https://api.edmunds.com/api/"
        static let Base_URL_v1 = "https://api.edmunds.com/v1/api/"
        static let VehicleAPI = "vehicle/v2/"
        static let MaintenanceAPI = "maintenance/actionrepository/"
        static let API_Key = "q2qy5bz6zz7xh5fbbcfcdzbc"
    }
    
    struct Methods {
    
        static let GetMakes = "makes"
        static let GetStyles = "styles"
        static let GetMaintenance = "findbymodelyearid"
    }
    
    struct Keys {
    
        static let DataView = "view"
        static let DataFormat = "fmt"
        static let APIKey = "api_key"
        static let ModelYearID = "modelyearid"
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
        static let Maintenance_Array = "actionHolder"
        static let MaintenanceItem_Engine = "engineCode"
        static let MaintenanceItem_Transmission = "transmissionCode"
        static let MaintenanceItem_IntMileage = "intervalMileage"
        static let MaintenanceItem_Action = "action"
        static let MaintenanceItem_Item = "item"
        static let MaintenanceItem_Description = "itemDescription"
    }
}
