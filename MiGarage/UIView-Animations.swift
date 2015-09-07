//
//  UIView-Animations.swift
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
    func rotate360Degrees(repeatCount: Float = 1.0, duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = repeatCount
        
        if let delegate: AnyObject = completionDelegate {
            
            rotateAnimation.delegate = delegate
        }
        
        self.layer.addAnimation(rotateAnimation, forKey: "rotation")
    }
    
    func fallAnimation(duration: CFTimeInterval = 1.0, hideOnCompletion: Bool, completionHandler: ((result: AnyObject?) -> Void)?) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 15 * CGFloat(M_PI/180)
        rotateAnimation.duration = duration
        rotateAnimation.removedOnCompletion = false
        
        let fallingView = CABasicAnimation(keyPath: "position")
        self.layer.position.y += 1000
        fallingView.duration = duration
        fallingView.removedOnCompletion = false
        
        var group = CAAnimationGroup()
        group.animations = [rotateAnimation, fallingView]
        group.duration = duration
        
        if hideOnCompletion {
            
            let hideAnimation = CABasicAnimation(keyPath: "hidden")
            self.layer.hidden = true
            
            group.animations.append(hideAnimation)
        }
        
        self.layer.addAnimation(group, forKey: "fallingObject")
    }
    
    func fadeOut(duration: CFTimeInterval = 1.0, hideOnCompletion: Bool, completionHandler: ((result: AnyObject?) -> Void)?) {
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        self.layer.opacity = 0.0
        fadeAnimation.duration = duration
        self.layer.addAnimation(fadeAnimation, forKey: "fade")
    }
}