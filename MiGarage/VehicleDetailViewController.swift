//
//  VehicleDetailViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/7/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController {
    
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var repairLogButton: UIButton!
    @IBOutlet weak var maintenanceButton: UIButton!
    @IBOutlet weak var odometerButton: SpringButton!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var coverPhotoUploadLabel: UILabel!
    @IBOutlet weak var vehicleNicknameLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var odometerLabel: UILabel!
    
    @IBAction func backButton(didTouchUpInside: UIButton) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func odometerButton(didTouchUpInside: UIButton) {
        
        var animationSettings = UIView.AnimationSettings()
        animationSettings.duration = 0.5
        odometerButton.clickIn(animationSettings, completionHandler: nil)
        let alert = UIAlertView(title: "Odometer Button", message: "Edit Odometer Reading", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func maintenanceButton(didTouchUpInside: UIButton) {
        
        var animationSettings = UIView.AnimationSettings()
        animationSettings.duration = 0.5
        maintenanceButton.clickIn(animationSettings, completionHandler: nil)
        let alert = UIAlertView(title: "Maintenance Button", message: "Show Maintenance Calendar", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func repairLogButton(didTouchUpInside: UIButton) {
        
        var animationSettings = UIView.AnimationSettings()
        animationSettings.duration = 0.5
        repairLogButton.clickIn(animationSettings, completionHandler: nil)
        let alert = UIAlertView(title: "Repair Button", message: "Show Repair Log", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func notesButton(didTouchUpInside: UIButton) {
        
        var animationSettings = UIView.AnimationSettings()
        animationSettings.duration = 0.5
        notesButton.clickIn(animationSettings, completionHandler: nil)
        let alert = UIAlertView(title: "Notes Button", message: "Edit Notes", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
}
