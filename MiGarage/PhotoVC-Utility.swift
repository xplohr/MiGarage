//
//  PhotoVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension PhotoGalleryViewController {
    
    // MARK: - http://nshipster.com/uialertcontroller/
    func showPhotoGalleryActionMenu() {
        
        let action = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let flickrAction = UIAlertAction(title: "Download from Flickr", style: UIAlertActionStyle.Default) {
            (_) in
            
            
        }
        action.addAction(flickrAction)
        
        let cameraRoll = UIAlertAction(title: "Choose from Camera Roll", style: .Default) {
            (_) in
            
        }
        action.addAction(cameraRoll)
        
        let camera = UIAlertAction(title: "Take a Photo", style: .Default) {
            (_) in
            
        }
        action.addAction(camera)
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) {
            (_) in
            
        }
        action.addAction(cancel)
        
        presentViewController(action, animated: true, completion: nil)
    }
}
