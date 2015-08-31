//
//  AddVehicleTextViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

protocol NotesViewDelegate {
    
    func didCompleteEditingNotes(notesView: AddVehicleTextViewController, newText: String?)
}

class AddVehicleTextViewController: UIViewController {
    
    var delegate: NotesViewDelegate?
    var vehicleNotes: String?
    
    @IBOutlet weak var vehicleTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if vehicleNotes != nil {
            
            vehicleTextField.text = vehicleNotes
        }
        
        vehicleTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        
        delegate?.didCompleteEditingNotes(self, newText: vehicleTextField.text)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
