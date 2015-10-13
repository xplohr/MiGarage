//
//  MaintenanceViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 10/11/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class MaintenanceViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var grayoutBackground: SpringView!
    @IBOutlet weak var loadingBackground: SpringImageView!
    @IBOutlet weak var loadingView: SpringView!
    var vehicleInfo: Vehicle?
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Maintenance")
        let sortByID = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByID]
        fetchRequest.predicate = NSPredicate(format: "engineCode == %@ AND (transmissionCode == %@ OR transmisstionCode == 'ALL'", self.vehicleInfo!.engineCode, self.vehicleInfo!.transmission)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance().managedObjectContext!, sectionNameKeyPath: "intervalMileage", cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Animation code provided by Spring: https://github.com/MengTo/Spring
        loadingView.animate()
        loadingBackground.rotate360Degrees(repeatCount: 30.0)
        
        fetchedResultsController.performFetch(nil)
        if fetchedResultsController.fetchedObjects != nil {
            
            self.loadingView.fallAnimation(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
            self.grayoutBackground.fadeOut(duration: 0.25, hideOnCompletion: true, completionHandler: nil)
        } else {
            
            loadMaintenanceData()
        }
    }
}
