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
            
            self.showAlbums()
        }
        action.addAction(cameraRoll)
        
        let camera = UIAlertAction(title: "Take a Photo", style: .Default) {
            (_) in
            
            self.showCamera()
        }
        action.addAction(camera)
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) {
            (_) in
            
        }
        action.addAction(cancel)
        
        presentViewController(action, animated: true, completion: nil)
    }
    
    func showCamera() {
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) || UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
            
            let takeAPicture = UIAlertController(title: "Camera Available", message: "Take a picture!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) {
                (_) in
                
            }
            takeAPicture.addAction(okAction)
            
            self.presentViewController(takeAPicture, animated: true, completion: nil)
        } else {
            
            let cameraUnavailable = UIAlertController(title: "No Camera Available", message: "Sorry, no camera available.", preferredStyle: .Alert)
            
            let darnAction = UIAlertAction(title: "Darn!", style: .Default) {
                (_) in
                
            }
            cameraUnavailable.addAction(darnAction)
            
            self.presentViewController(cameraUnavailable, animated: true, completion: nil)
        }
    }
    
    func showAlbums() {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}
