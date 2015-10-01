//
//  FlickrGalleryCell.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/27/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class FlickrGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    
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
    
    func setCheckmark() {
        
        checkmarkImageView.hidden = !checkmarkImageView.hidden
    }
}