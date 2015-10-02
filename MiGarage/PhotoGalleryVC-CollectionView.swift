//
//  PhotoGalleryVC-CollectionView.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/21/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

extension PhotoGallery2ViewController {
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !fetchedResultsController.fetchedObjects!.isEmpty {
            
            return fetchedResultsController.fetchedObjects!.count
        }
        
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MiGarageUtility.ReuseIdentifiers.VehiclePhotoCell, forIndexPath: indexPath) as! VehiclePhotoCell
        
        cell.backgroundColor = UIColor.grayColor()
        
        let photoInfo = fetchedResultsController.objectAtIndexPath(indexPath) as! VehiclePhoto
        
        if let storedImage = photoInfo.getStoredImage() {
            
            cell.setPhoto(storedImage, hidden: false)
            cell.setLoadingIndicator(false)
        } else {
            
            cell.setPhoto(nil, hidden: true)
            cell.setLoadingIndicator(true)
        }
        
        return cell
    }
}
