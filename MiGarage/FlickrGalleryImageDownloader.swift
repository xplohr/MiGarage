//
//  FlickrGalleryImageDownloader.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/30/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class FlickrGalleryImageDownloader: NSOperation {
    
    var photoInfo: [String: AnyObject]
    
    init(info: [String: AnyObject]) {
        
        self.photoInfo = info
    }
    
    override func main() {
        
        if self.cancelled {
            
            return
        }
        
        let imageData = NSData(contentsOfURL: NSURL(string: photoInfo[FlickrClient.JSONKeys.Photo_URL] as! String)!)
        
        if imageData?.length > 0 {
            
            photoInfo[FlickrClient.JSONKeys.Photo_DownloadedImage] = UIImage(data: imageData!)
        } else {
            
            photoInfo[FlickrClient.JSONKeys.Photo_DownloadedImage] = nil
        }
    }
}