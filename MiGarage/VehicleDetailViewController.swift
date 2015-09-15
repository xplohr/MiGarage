//
//  VehicleDetailViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/7/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController {
    
    var vehicleData: Vehicle?
    
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var repairLogButton: UIButton!
    @IBOutlet weak var maintenanceButton: UIButton!
    @IBOutlet weak var odometerButton: SpringButton!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var coverPhotoUploadLabel: UILabel!
    @IBOutlet weak var vehicleNicknameLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var odometerLabel: UILabel!
    
    override func viewDidLoad() {
        
        if vehicleData != nil {
            
            vehicleNicknameLabel.text = vehicleData?.getNameForLabel()
            vehicleNameLabel.text = vehicleData?.getModelForLabel()
            odometerLabel.text = vehicleData?.odometer.stringValue
        }
    }
    
    @IBAction func backButton(didTouchUpInside: UIButton) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func odometerButtonDidTouchUpInside(sender: UIButton) {
        
        showOdometerEntryView(sender)
    }
    
    @IBAction func buttonTouchDown(sender: UIButton) {
        
        var animationSettings = UIView.AnimationSettings()
        animationSettings.duration = 0.5
        sender.clickIn(animationSettings, completionHandler: nil)
    }
    
    @IBAction func maintenanceButtonDidTouchUpInside(sender: UIButton) {
        
        let alert = UIAlertView(title: "Maintenance Button", message: "Show Maintenance Calendar", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func repairLogButtonDidTouchUpInside(sender: UIButton) {
        
        let alert = UIAlertView(title: "Repair Button", message: "Show Repair Log", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func notesButtonDidTouchUpInside(sender: UIButton) {
        
        let alert = UIAlertView(title: "Notes Button", message: "Edit Notes", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    @IBAction func vehicleNameButtonDidTouchUpInside(sender: UIButton) {
        
        showNicknameEntryView(sender)
    }
}
