//
//  AddVehicleMenuViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

protocol AddVehicleMenuDelegate {
    
    func didSelectMenuItem(addVehicleMenu: AddVehicleMenuViewController, vehicleInfo: String, selection: String)
}

class AddVehicleMenuViewController: UITableViewController {
    
    var menuChoices: [String] = []
    var delegate: AddVehicleMenuDelegate?
    
    override func viewDidLoad() {
        
        tableView.reloadData()
    }
}
