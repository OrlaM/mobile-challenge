//
//  NSConstraintExtension.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
