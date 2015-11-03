//
//  MaintenanceVC-TableView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 10/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension MaintenanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = fetchedResultsController.fetchedObjects![indexPath.row] as! Maintenance
        let cell = tableView.dequeueReusableCellWithIdentifier(MiGarageUtility.ReuseIdentifiers.MaintenanceCell)!
        cell.textLabel?.text = item.action
        cell.detailTextLabel?.text = item.item
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        
        if item.action == "Change" || item.action == "Flush/replace" {
            
            cell.imageView?.image = UIImage(named: "Fill")
        } else if item.action == "Replace" {
            
            cell.imageView?.image = UIImage(named: "Replace")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let item = fetchedResultsController.fetchedObjects![indexPath.row] as! Maintenance
        let itemDetail = UIAlertController(title: item.item, message: item.itemDescription, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "Close", style: .Default) { (_) in }
        itemDetail.addAction(okButton)
        
        presentViewController(itemDetail, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let sectionInfo: AnyObject = fetchedResultsController.sections?[section] {
            
            return sectionInfo.name
        } else {
            
            return nil
        }
    }
    
}
