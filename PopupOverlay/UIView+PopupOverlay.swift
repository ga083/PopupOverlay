//
//  UIView+PopupOverlay.swift
//  PopupOverlay
//
//  Created by Alexander Solis on 6/2/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import UIKit

extension UIView {
    static func popupView(size: CGSize,
                          cornerRadius: CGFloat,
                          color: UIColor) -> UIView {
        let containerViewRect = CGRect(origin: .zero, size: size)
        let view = UIView(frame: containerViewRect)
        
        let overlay = UIView.createOverlay(backgroundColor: color)
        
        view.center = CGPoint(
            x: overlay.bounds.size.width/2,
            y: overlay.bounds.size.height/2
        )
        
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = color
        
        overlay.addSubview(view)
        
        view.centerViewInSuperview()
        
        return view
    }
    
    private static func createOverlay(backgroundColor: UIColor) -> UIView {
        let window = UIApplication.shared.delegate!.window!!
        
        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = backgroundColor
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(overlay)
        
        let viewsDictionary = ["blocker": overlay]
        
        // Add constraints to handle orientation change
        let constraintsV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[blocker]-0-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
        )
        
        let constraintsH = NSLayoutConstraint.constraints(
            withVisualFormat: "|-0-[blocker]-0-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
        )
        
        window.addConstraints(constraintsV + constraintsH)
        
        return overlay
    }

    private func centerViewInSuperview() {
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
