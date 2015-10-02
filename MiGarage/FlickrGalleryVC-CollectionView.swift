//
//  FlickrGalleryVC-CollectionView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/28/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension FlickrGalleryViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if flickrPhotos.isEmpty {
            
            return 1
        } else {
            
            return flickrPhotos.count
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MiGarageUtility.ReuseIdentifiers.FlickrPhotoCell, forIndexPath: indexPath) as! FlickrGalleryCell
        
        if flickrPhotos.isEmpty {
            
            cell.backgroundColor = UIColor.grayColor()
            cell.setPhoto(nil, hidden: true)
            cell.setLoadingIndicator(true)
            return cell
        }
        
        let photoInfo = flickrPhotos[indexPath.row]
        
        cell.backgroundColor = UIColor.grayColor()
        
        if let image = photoInfo[FlickrClient.JSONKeys.Photo_DownloadedImage] as? UIImage {
            
            cell.setPhoto(image, hidden: false)
            cell.setLoadingIndicator(false)
        } else {
            
            cell.setPhoto(nil, hidden: true)
            cell.setLoadingIndicator(true)
            
            if !collectionView.dragging && !collectionView.decelerating {
                
                downloadImageInBackground(photoInfo, indexPath: indexPath)
            }
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FlickrGalleryCell
        cell.setCheckmark()
        
        let selectedInfo = flickrPhotos[indexPath.row]
        let selectedKey = selectedInfo[FlickrClient.JSONKeys.Photo_ID] as! String
        
        if cell.checkmarkImageView.hidden {
            
            selectedPhotos[selectedKey] = nil
        } else {
            
            selectedPhotos[selectedKey] = selectedInfo
        }
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        OperationQueueManager.sharedInstance().suspendAllOperations()
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            loadImagesForOnscreenCells()
            OperationQueueManager.sharedInstance().resumeAllOperations()
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        loadImagesForOnscreenCells()
        OperationQueueManager.sharedInstance().resumeAllOperations()
    }
}