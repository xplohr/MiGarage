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
    @NSManaged var odometer: NSNumber
    @NSManaged var photos: [VehiclePhoto]
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(vehicleData: AddVehicleViewController.VehicleInfo, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Vehicle", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        make = vehicleData.make!
        model = vehicleData.model!
        year = vehicleData.year!
        odometer = 0.0
        
        if vehicleData.nickname != nil {
            nickname = vehicleData.nickname!
        }
        
        if vehicleData.notes != nil {
            notes = vehicleData.notes!
        }
    }

    func getNameForLabel() -> String {
        
        if !self.nickname.isEmpty {
            return self.nickname
        } else {
            return "\(self.make)"
        }
    }
    
    func getModelForLabel() -> String {
        
        return "\(self.year) \(self.make) \(self.model)"
    }
    
    func createPhotoEntries(data: [[String: AnyObject]]) {
        
        for photoInfo: [String: AnyObject] in data {
            
            let photoTitle = photoInfo[FlickrClient.JSONKeys.Photo_Title] as! String
            let photoURL = photoInfo[FlickrClient.JSONKeys.Photo_URL] as! String
            let photoID = photoInfo[FlickrClient.JSONKeys.Photo_ID] as! String
            let dictionary: [String: AnyObject] = [
            
                VehiclePhoto.Keys.ImageID: photoID,
                VehiclePhoto.Keys.Name: photoTitle,
                VehiclePhoto.Keys.ImageURL: photoURL
            ]
            
            let newPhoto = VehiclePhoto(values: dictionary, context: CoreDataStackManager.sharedInstance().managedObjectContext!)
        }
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // MARK: - Flickr methods
}
