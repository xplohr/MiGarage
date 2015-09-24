//
//  PhotoGalleryViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import CoreData

class PhotoGalleryViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var collectionView: UICollectionView!
    
    var vehicle: Vehicle?
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "VehiclePhoto")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "vehicle == %@", self.vehicle!)
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance().managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchedResultsController.performFetch(nil)
        fetchedResultsController.delegate = self
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        fetchedResultsController.performFetch(nil)
        collectionView.reloadData()
        
        if fetchedResultsController.fetchedObjects?.count == 0 {
            
            showPhotoGalleryActionMenu()
        }
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addBarButtonTouchUpInside(sender: UIBarButtonItem) {
        
        showPhotoGalleryActionMenu()
    }
}
