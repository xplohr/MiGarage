//
//  OperationQueueManager.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/30/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import Foundation

class OperationQueueManager {
    
    lazy var downloadsInProgress = [NSIndexPath: NSOperation]()
    lazy var downloadQueue: NSOperationQueue = {
        
        var queue = NSOperationQueue()
        queue.name = "Flickr Gallery Download Queue"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    class func sharedInstance() -> OperationQueueManager {
        
        struct Singelton {
            
            static var instance = OperationQueueManager()
        }
        
        return Singelton.instance
    }
    
    func suspendAllOperations() {
        
        downloadQueue.suspended = true
    }
    
    func resumeAllOperations() {
        
        downloadQueue.suspended = false
    }
}
