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
    
    var newVehicle: VehicleInfo? = VehicleInfo()
    var vehicleData: Vehicle?
    
    override func viewDidLoad() {
        
        if vehicleData != nil {
            
            newVehicle?.make = vehicleData?.make
            newVehicle?.model = vehicleData?.model
            newVehicle?.year = vehicleData?.year
            newVehicle?.nickname = vehicleData?.nickname
            newVehicle?.notes = vehicleData?.notes
        }
        
        EdmundsClient.sharedInstance().getEdmundsDataForMenus() {
            
            success, data, error in
            
            println("\(success)")
            // Process data into menus
        }
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
        
        newVehicle?.nickname = getNicknameValue()
        
        let vehicleData = Vehicle(vehicleData: newVehicle!, context: CoreDataStackManager.sharedInstance().managedObjectContext!)
        CoreDataStackManager.sharedInstance().saveContext()
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == MiGarageUtility.SegueIdentifiers.AddVehicleMenu {
            
            let destination = segue.destinationViewController as! AddVehicleMenuViewController
            destination.menuChoices = setupMenuChoices(sender as! Int)
            destination.title = setupTitle(sender as! Int)
            destination.delegate = self
        }
        else if segue.identifier == MiGarageUtility.SegueIdentifiers.ShowNotesView {
            
            let destination = segue.destinationViewController as! AddVehicleTextViewController
            destination.delegate = self
            destination.vehicleNotes = newVehicle?.notes
        }
    }
}
