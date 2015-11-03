//
//  MaintenanceViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 10/11/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class MaintenanceViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var grayoutBackground: SpringView!
    @IBOutlet weak var loadingBackground: SpringImageView!
    @IBOutlet weak var loadingView: SpringView!
    @IBOutlet weak var maintenanceTable: UITableView!
    
    var vehicleInfo: Vehicle?
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Maintenance")
        let sortByID = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByID]
        fetchRequest.predicate = NSPredicate(format: "engineCode == %@ AND (transmissionCode == %@ OR transmissionCode == 'ALL')", self.vehicleInfo!.engineCode, self.vehicleInfo!.transmission)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance().managedObjectContext!, sectionNameKeyPath: "intervalMileage", cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Animation code provided by Spring: https://github.com/MengTo/Spring
        loadingView.animate()
        loadingBackground.rotate360Degrees(30.0)
        
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        if fetchedResultsController.fetchedObjects!.isEmpty {
            
            loadMaintenanceData()
        } else {
            
            self.loadingView.fallAnimation(0.25, hideOnCompletion: true, completionHandler: nil)
            self.grayoutBackground.fadeOut(0.25, hideOnCompletion: true, completionHandler: nil)
        }
        
    }
    
    @IBAction func doneButtonDidTouchUpInside(sender: UIBarButtonItem) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
