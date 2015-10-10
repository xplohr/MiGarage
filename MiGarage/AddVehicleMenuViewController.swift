//
//  AddVehicleMenuViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

protocol AddVehicleMenuDelegate {
    
    func didSelectMenuItem(addVehicleMenu: AddVehicleMenuViewController, vehicleInfo: String, selection: String, details: [String: AnyObject])
}

class AddVehicleMenuViewController: UITableViewController {
    
    var menuChoices: [String: [String: AnyObject]]?
    var delegate: AddVehicleMenuDelegate?
    var sortedChoices: [String]?
    
    override func viewDidLoad() {
        
        sortedChoices = menuChoices!.keys.array
        sortedChoices?.sort {
            
            $0 < $1
        }
        
        tableView.reloadData()
    }
}
