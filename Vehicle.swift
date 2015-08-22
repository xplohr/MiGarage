//
//  Vehicle.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import Foundation
import CoreData

class Vehicle: NSManagedObject {

    @NSManaged var make: String
    @NSManaged var model: String
    @NSManaged var nickname: String
    @NSManaged var notes: String
    @NSManaged var year: NSNumber
    
    lazy var nameForLabel: String = {
        
        if !self.nickname.isEmpty {
            return self.nickname
        } else {
            return "\(self.make)"
        }
    }()
    
    lazy var modelForLabel: String = {
        
        return "\(self.year) \(self.make) \(self.model)"
    }()

}
