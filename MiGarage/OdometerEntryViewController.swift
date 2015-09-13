//
//  OdometerEntryViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class OdometerEntryViewController: UIViewController {
    
    
    @IBAction func cancelButtonDidTouchUpInside(sender: UIButton) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
