//
//  DocumentsDirManager.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/19/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit

class DocumentsDirManager: NSObject {
    
    class func sharedInstance() -> DocumentsDirManager {
        
        struct Singleton {
            
            static var instance = DocumentsDirManager()
        }
        
        return Singleton.instance
    }
    
    lazy var documentsDirectory: String = {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let directory = urls[0] 
        
        return directory.path!
    }()
    
    func getImagePath(title: String) -> String {
        
        return (documentsDirectory as NSString).stringByAppendingPathComponent("\(title).png")
    }
    
    func writeImageData(imageData: NSData, title: String) {
        
        let writePath = getImagePath(title)
        let image = UIImage(data: imageData)
        
        if image == nil {
            
            print("Bad image data for \(title). Did not write to Documents.")
            return
        }
        
        UIImagePNGRepresentation(image!)!.writeToFile(writePath, atomically: true)
    }
    
    func writeImage(image: UIImage, title: String) -> String {
        
        let writePath = getImagePath(title)
        UIImagePNGRepresentation(image)!.writeToFile(writePath, atomically: true)
        
        return writePath
    }
    
    func getImageFromPath(path: String) -> UIImage? {
        
        return UIImage(named: path)
    }
    
    func getImageFromTitle(title: String) -> UIImage? {
        
        let readPath = getImagePath(title)
        
        return UIImage(named: readPath)
    }
    
    func removeDocument(name: String) {
        
        let pathToDelete = (documentsDirectory as NSString).stringByAppendingPathComponent(name)
        do {
            try NSFileManager.defaultManager().removeItemAtPath(pathToDelete)
        } catch _ {
        }
    }
}
