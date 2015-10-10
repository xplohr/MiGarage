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
        var makeNicename: String?
        var model: String?
        var modelNicename: String?
        var year: NSNumber?
        var modelYearID: String?
        var nickname: String?
        var notes: String?
        var engineCode: String?
        var engineType: String?
        var transCode: String?
        var transType: String?
    }
    
    @IBOutlet weak var grayoutBackground: SpringView!
    @IBOutlet weak var loadingBackground: SpringImageView!
    @IBOutlet weak var loadingView: SpringView!
    var newVehicle: VehicleInfo? = VehicleInfo()
    var vehicleData: Vehicle?
    var edmundsData: [[String: AnyObject]]?
    var engineData = [String: [String: AnyObject]]()
    var transmissionData = [String: [String: AnyObject]]()
    
    override func viewDidLoad() {
        
        if vehicleData != nil {
            
            newVehicle?.make = vehicleData?.make
            newVehicle?.model = vehicleData?.model
            newVehicle?.year = vehicleData?.year
            
            if !vehicleData!.nickname.isEmpty {
                newVehicle?.nickname = vehicleData?.nickname
            }
            
            if !vehicleData!.notes.isEmpty {
                newVehicle?.notes = vehicleData?.notes
            }
        }
        
        // Animation code provided by Spring: https://github.com/MengTo/Spring
        loadingView.animate()
        loadingBackground.rotate360Degrees(repeatCount: 30.0)
        
        EdmundsClient.sharedInstance().getEdmundsDataForMenus() {
            
            success, data, error in
            
            if success {
                
                self.edmundsData = data
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.loadingView.fallAnimation(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
                    self.grayoutBackground.fadeOut(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
                }
            } else {
                
                println("\(error): \(error?.userInfo)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let alert = UIAlertView(title: "Error", message: "Whoops! There was an error retrieving the data from Edmunds.com. Please try again.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    @IBOutlet weak var vehicleTable: UITableView!
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        if (newVehicle?.make == nil ||
            newVehicle?.model == nil ||
            newVehicle?.year == nil ||
            newVehicle?.engineCode == nil ||
            newVehicle?.transCode == nil) {
                
            let alert = UIAlertView(title: "Missing Data", message: "Please make sure the Make, Model, Year, Engine Type, and Transmission of the vehicle has proper selections.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        
        newVehicle?.nickname = getNicknameValue()
        
        if newVehicle?.notes == nil {
            newVehicle?.notes = ""
        }
        
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
