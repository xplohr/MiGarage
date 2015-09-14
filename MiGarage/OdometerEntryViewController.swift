//
//  OdometerEntryViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

protocol OdometerEntryViewControllerDelegate {
    
    func didSaveOdometerReading(sender: OdometerEntryViewController, value: String)
}

class OdometerEntryViewController: UIViewController {
    
    @IBOutlet weak var odometerTextField: UITextField!
    
    var delegate: OdometerEntryViewControllerDelegate?
    var vehicleData: Vehicle?
    
    override func viewDidAppear(animated: Bool) {
        
        if vehicleData != nil {
            
            odometerTextField.text = vehicleData?.odometer.stringValue
        }
        
        odometerTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonDidTouchUpInside(sender: UIButton) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonDidTouchUpInside(sender: UIButton) {
        
        delegate?.didSaveOdometerReading(self, value: odometerTextField.text)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
