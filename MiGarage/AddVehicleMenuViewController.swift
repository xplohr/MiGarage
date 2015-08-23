//
//  AddVehicleMenuViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 8/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class AddVehicleMenuViewController: UITableViewController {
    
    var menuChoices: [String] = []
    
    override func viewDidLoad() {
        
        tableView.reloadData()
    }
}
