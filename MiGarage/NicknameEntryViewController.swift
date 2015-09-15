//
//  NicknameEntryViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/15/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

protocol NicknameEntryViewControllerDelegate {

    func didSaveNickname(sender: NicknameEntryViewController, value: String)
}

class NicknameEntryViewController: UIViewController {
    
    var delegate: NicknameEntryViewControllerDelegate?
    var vehicleData: Vehicle?
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        
        if vehicleData != nil {
            
            nicknameTextField.text = vehicleData?.nickname
        }
        
        nicknameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonDidTouchUpInside(sender: UIButton) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonDidTouchUpInside(sender: UIButton) {
        
        delegate?.didSaveNickname(self, value: nicknameTextField.text)
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}