//
//  AddVehicleViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class AddVehicleViewController: UIViewController {
    
    struct VehicleInfo {
    
        var make: String?
        var model: String?
        var year: NSNumber?
        var nickname: String?
        var notes: String?
    }
    
    var newVehicle: VehicleInfo?
    
    override func viewDidLoad() {
        
        newVehicle = VehicleInfo()
    }
    
    @IBOutlet weak var vehicleTable: UITableView!
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        if (newVehicle?.make == nil ||
            newVehicle?.model == nil ||
            newVehicle?.year == nil) {
                
            let alert = UIAlertView(title: "Missing Data", message: "Please make sure the Make, Model, and Year of the vehicle has proper selections.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        
        let vehicleData = Vehicle(vehicleData: newVehicle!, context: CoreDataStackManager.sharedInstance().managedObjectContext!)
        CoreDataStackManager.sharedInstance().saveContext()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == MiGarageUtility.SegueIdentifiers.AddVehicleMenu {
            
            var destination = segue.destinationViewController as! AddVehicleMenuViewController
            destination.menuChoices = setupMenuChoices(sender as! Int)
            destination.title = setupTitle(sender as! Int)
            destination.delegate = self
        }
    }
}
