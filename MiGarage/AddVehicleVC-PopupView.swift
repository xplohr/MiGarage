//
//  AddVehicleVC-PopupView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/30/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension AddVehicleViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.None
    }
}
