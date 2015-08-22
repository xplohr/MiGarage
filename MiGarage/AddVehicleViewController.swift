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
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    }
}
