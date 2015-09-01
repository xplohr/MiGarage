//
//  MiGarageError.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/31/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import Foundation

class MiGarageError: NSObject {
    
    struct UserInfoKeys {
    
        static let Description = "description"
    }
    
    struct ErrorCodes {
    
        static let EdmundsMakesDictionaryError: Int = 100
    }
    
    static let Domain = "MiGarage"
}