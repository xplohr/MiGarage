//
//  VehiclePhotoCell.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class VehiclePhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setPhoto(image: UIImage?, hidden: Bool) {
        
        self.imageView.image = image
        self.imageView.hidden = hidden
    }
    
    func setLoadingIndicator(animating: Bool) {
        
        if animating {
            
            self.activityIndicator.startAnimating()
        } else {
            
            self.activityIndicator.stopAnimating()
        }
    }
}
