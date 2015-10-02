//
//  FlickrGalleryVC-Utility.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/30/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension FlickrGalleryViewController {
    
    func downloadImageInBackground(photoInfo: [String: AnyObject], indexPath: NSIndexPath) {
        
        if let downloadOperation = OperationQueueManager.sharedInstance().downloadsInProgress[indexPath] {
            
            return
        }
        
        let downloader = FlickrGalleryImageDownloader(info: photoInfo)
        downloader.completionBlock = {
            
            if downloader.cancelled {
                
                return
            }
            
            self.flickrPhotos[indexPath.row] = downloader.photoInfo
            
            dispatch_async(dispatch_get_main_queue()) {
                
                OperationQueueManager.sharedInstance().downloadsInProgress.removeValueForKey(indexPath)
                self.collectionView?.reloadItemsAtIndexPaths([indexPath])
            }
        }
        
        OperationQueueManager.sharedInstance().downloadsInProgress[indexPath] = downloader
        OperationQueueManager.sharedInstance().downloadQueue.addOperation(downloader)
    }
    
    func loadImagesForOnscreenCells() {
        
        let pathsArray = collectionView!.indexPathsForVisibleItems()
        
        if !pathsArray.isEmpty {
            
            var allPendingOperations = Set(OperationQueueManager.sharedInstance().downloadsInProgress.keys.array)
            var toBeCancelled = allPendingOperations
            let visiblePaths = Set(pathsArray as! [NSIndexPath])
            toBeCancelled.subtractInPlace(visiblePaths)
            
            var toBeStarted = visiblePaths
            toBeStarted.subtractInPlace(allPendingOperations)
            
            for indexPath in toBeCancelled {
                
                if let pendingDownload = OperationQueueManager.sharedInstance().downloadsInProgress[indexPath] {
                    
                    pendingDownload.cancel()
                }
                
                OperationQueueManager.sharedInstance().downloadsInProgress.removeValueForKey(indexPath)
            }
            
            for indexPath in toBeStarted {
                
                let indexPath = indexPath as NSIndexPath
                let recordToProcess = flickrPhotos[indexPath.row]
                downloadImageInBackground(recordToProcess, indexPath: indexPath)
            }
        }
    }
    
    func downloadFromFlickr() {
        
        let tags = [vehicle!.year.stringValue, vehicle!.make, vehicle!.model]
        
        FlickrClient.sharedInstance().searchByTags(tags, inclusiveSearch: true) {
            data, error in
            
            if let flickrError = error {
                
                print("Error downloading photos from Flickr: \(error), \(error?.description)")
                let alert = UIAlertController(title: "Download Error", message: "Whoops! Something went wrong while downloading from Flickr. Please Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default) {
                    (_) in
                    
                    
                }
                alert.addAction(okButton)
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                
                self.flickrPhotos = data as [[String: AnyObject]]!
                /*let subset = [self.flickrPhotos[0], self.flickrPhotos[1], self.flickrPhotos[2], self.flickrPhotos[3], self.flickrPhotos[4]]
                self.flickrPhotos = subset*/
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
}