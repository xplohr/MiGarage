//
//  PhotoGalleryVC-Images.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/23/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension PhotoGalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        if let pickedImage = editingInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            
            vehicle?.addPhoto(pickedImage, title: nil)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}