//
//  VehicleDetailVC-Ext.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension VehicleDetailViewController: UIPopoverPresentationControllerDelegate, OdometerEntryViewControllerDelegate, NicknameEntryViewControllerDelegate, NotesViewDelegate {
    
    // Reference: http://gracefullycoded.com/display-a-popover-in-swift/
    func showOdometerEntryView(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var odometerEntryVC: OdometerEntryViewController = storyboard.instantiateViewControllerWithIdentifier("OdometerEntry") as! OdometerEntryViewController
        odometerEntryVC.modalPresentationStyle = .Popover
        odometerEntryVC.preferredContentSize = CGSizeMake(250.0, 110.0)
        odometerEntryVC.delegate = self
        odometerEntryVC.vehicleData = vehicleData
        
        let popoverVC = odometerEntryVC.popoverPresentationController
        popoverVC?.permittedArrowDirections = .Any
        popoverVC?.delegate = self
        popoverVC?.sourceView = sender
        popoverVC?.sourceRect = CGRect(x: sender.frame.width/2, y: sender.frame.height/3, width: 1, height: 1)
        presentViewController(odometerEntryVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    func showNicknameEntryView(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var nicknameEntryVC: NicknameEntryViewController = storyboard.instantiateViewControllerWithIdentifier("NicknameEntry") as! NicknameEntryViewController
        nicknameEntryVC.modalPresentationStyle = .Popover
        nicknameEntryVC.preferredContentSize = CGSizeMake(250.0, 110.0)
        nicknameEntryVC.delegate = self
        nicknameEntryVC.vehicleData = vehicleData
        
        let popoverVC = nicknameEntryVC.popoverPresentationController
        popoverVC?.permittedArrowDirections = .Any
        popoverVC?.delegate = self
        popoverVC?.sourceView = sender
        popoverVC?.sourceRect = CGRect(x: sender.frame.width/2, y: 0, width: 1, height: 1)
        presentViewController(nicknameEntryVC, animated: true, completion: nil)
    }
    
    // MARK: - OdometerEntryViewControllerDelegate
    func didSaveOdometerReading(sender: OdometerEntryViewController, value: String) {
        
        odometerLabel.text = value
        vehicleData?.odometer = (value as NSString).floatValue
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // MARK: - NicknameEntryViewControllerDelegate
    func didSaveNickname(sender: NicknameEntryViewController, value: String) {
        
        vehicleNicknameLabel.text = value
        vehicleData?.nickname = value
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // MARK: - NotesViewDelegate
    func didCompleteEditingNotes(notesView: AddVehicleTextViewController, newText: String?) {
        
        vehicleData?.notes = newText!
        CoreDataStackManager.sharedInstance().saveContext()
    }
}
