//
//  Maintenance.swift
//  
//
//  Created by Che-Chuen Ho on 10/12/15.
//
//

import Foundation
import CoreData

class Maintenance: NSManagedObject {

    @NSManaged var action: String
    @NSManaged var id: NSNumber
    @NSManaged var intervalMileage: NSNumber
    @NSManaged var item: String
    @NSManaged var itemDescription: String
    @NSManaged var transmissionCode: String
    @NSManaged var engineCode: String
    @NSManaged var vehicle: Vehicle
    
    struct Keys {
    
        static let Action = "action"
        static let ID = "id"
        static let IntervalMiles = "miles"
        static let ItemName = "item"
        static let Description = "description"
        static let Transmission = "trans"
        static let Engine = "engine"
        static let Vehicle = "vehicle"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(values: [String: AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Maintenance", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.action = values[Keys.Action] as! String
        self.id = values[Keys.ID] as! Int
        self.intervalMileage = values[Keys.IntervalMiles] as! Int
        self.item = values[Keys.ItemName] as! String
        self.itemDescription = values[Keys.Description] as! String
        self.transmissionCode = values[Keys.Transmission] as! String
        self.engineCode = values[Keys.Engine] as! String
        self.vehicle = values[Keys.Vehicle] as! Vehicle
    }

}
