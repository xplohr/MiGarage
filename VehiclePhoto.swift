//
//  VehiclePhoto.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/19/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class VehiclePhoto: NSManagedObject {
    
    struct Keys {
    
        static let ImageID = "ID"
        static let Name = "name"
        static let ImageURL = "url"
    }
    
    struct PhotoRecordState {
    
        static let New = 0
        static let Downloaded = 1
        static let Failed = 2
    }

    @NSManaged var id: String
    @NSManaged var imageURL: String
    @NSManaged var localImagePath: String
    @NSManaged var state: NSNumber
    @NSManaged var title: String
    @NSManaged var vehicle: Vehicle
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(values: [String: AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("VehiclePhoto", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.id = values[Keys.ImageID] as! String
        self.title = values[Keys.Name] as! String
        self.imageURL = values[Keys.ImageURL] as! String
        self.state = PhotoRecordState.New
    }
    
    func getStoredImage() -> UIImage? {
        
        return DocumentsDirManager.sharedInstance().getImageFromTitle(self.id)
    }
    
    override func prepareForDeletion() {
        
        DocumentsDirManager.sharedInstance().removeDocument("\(id).png")
    }

}
