//
//  FlickrGalleryViewController.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/27/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class FlickrGalleryViewController: UICollectionViewController {
    
    var flickrPhotos = [[String: AnyObject]]()
    var vehicle: Vehicle?
    var selectedPhotos = [String: [String: AnyObject]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        downloadFromFlickr()
    }
    
    @IBAction func saveButtonDidTouchUpInside(sender: UIBarButtonItem) {
        
        
    }
}
