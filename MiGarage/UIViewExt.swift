//
//  UIViewExt.swift
//  MiGarage
//
//  Created by Che-Chuen Ho on 9/6/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit


extension UIView {
    
    // Extending UIView to create a rotating animation
    // Reference: https://www.andrewcbancroft.com/2014/10/15/rotate-animation-in-swift/
    // Modified by Che-Chuen Ho to repeat animations
    func rotate360Degrees(repeatCount: Float = 1.0, duration: CFTimeInterval = 1.0, completionHandler: AnyObject? = nil) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = repeatCount
        
        if let delegate: AnyObject = completionHandler {
            
            rotateAnimation.delegate = delegate
        }
        
        self.layer.addAnimation(rotateAnimation, forKey: "rotation")
    }
    
    func fallAnimation(duration: CFTimeInterval = 1.0, completionHandler: AnyObject? = nil) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 15 * CGFloat(M_PI/180)
        rotateAnimation.duration = 0.25
        rotateAnimation.removedOnCompletion = false
        self.layer.addAnimation(rotateAnimation, forKey: "rotation")
        
        let fallingView = CABasicAnimation(keyPath: "position")
        self.layer.position.y += 1000
        fallingView.duration = 0.25
        self.layer.addAnimation(fallingView, forKey: "fall")
    }
}
