//
//  PhotoDetailViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/23/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var vehicleData: Vehicle?
    var vehicleImage: VehiclePhoto?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        imageView.image = DocumentsDirManager.sharedInstance().getImageFromTitle(vehicleImage!.id)
    }
    
    @IBAction func coverArtBarButtonDidTouchUpInside(sender: UIBarButtonItem) {
        
        vehicleData?.coverPhotoURL = DocumentsDirManager.sharedInstance().getImagePath(vehicleImage!.id)
        CoreDataStackManager.sharedInstance().saveContext()
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func trashBarButtonDidTouchUpInside(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this photo?", preferredStyle: .Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Destructive) {
            (_) in
            
            DocumentsDirManager.sharedInstance().removeDocument(self.vehicleImage!.id)
            CoreDataStackManager.sharedInstance().managedObjectContext?.deleteObject(self.vehicleImage!)
            self.vehicleData?.coverPhotoURL = ""
            CoreDataStackManager.sharedInstance().saveContext()
            
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(yesAction)
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) {
            (_) in
            
        }
        alert.addAction(noAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
