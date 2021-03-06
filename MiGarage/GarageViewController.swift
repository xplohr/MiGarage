//
//  GarageViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/16/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class GarageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Vehicle")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nickname", ascending: true), NSSortDescriptor(key: "make", ascending: true), NSSortDescriptor(key: "model", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance().managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        fetchedResultsController.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == MiGarageUtility.SegueIdentifiers.VehicleDetails && sender != nil) {
            
            let navController = segue.destinationViewController as!  UINavigationController
            let destination = navController.topViewController as! AddVehicleViewController
            destination.vehicleData = sender as? Vehicle
        } else if (segue.identifier == MiGarageUtility.SegueIdentifiers.VehicleDash && sender != nil) {
            
            let destination = segue.destinationViewController as! VehicleDetailViewController
            destination.vehicleData = sender as? Vehicle
        }
    }

    @IBAction func AddButtonTapped(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier(MiGarageUtility.SegueIdentifiers.VehicleDetails, sender: nil)
    }

}

