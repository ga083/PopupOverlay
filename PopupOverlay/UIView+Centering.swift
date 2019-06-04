//
//  UIView+Centering.swift
//  PopupOverlay
//
//  Created by Alexander Solis on 6/2/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import UIKit

extension UIView {
    func centerViewInSuperview() {
        assert(self.superview != nil, "`view` should have a superview")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintH = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.superview,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1,
            constant: 0
        )
        let constraintV = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.superview,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0
        )
        let constraintWidth = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: self.frame.size.width
        )
        let constraintHeight = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: self.frame.size.height
        )
        self.superview!.addConstraints([constraintV, constraintH, constraintWidth, constraintHeight])
    }
}
