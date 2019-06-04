//
//  PopupOverlay.swift
//  PopupOverlay
//
//  Created by Alexander Solis on 6/2/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import UIKit

class PopupOverlay {
    var font: UIFont!
    var textColor: UIColor!
    var backgroundColor: UIColor!
    
    var cornerRadius: CGFloat!
    var padding: CGFloat!
    
    private var tapGesture: UITapGestureRecognizer!
    
    private let containerViewTag = 456987123
    
    init() {
        self.setDefaultAppearance()
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(self.closePopupOverlay))
    }
    
    /**
     Sets/restores the original appearance of the popupOverlay.
     */
    open func setDefaultAppearance() {
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        cornerRadius = CGFloat(10)
        padding = CGFloat(10)
    }
    
    /**
     Presents the PopupOverlay on screen.
     - parameter text: the String that will be part of the PopupOverlay.
     - parameter image: an optional UIImage that will appear on top of the PopupOverlay text.
     - returns: the UIImage object that represents the PopupOverlay.
     
     The 'text' parameter can be a single line string literal:
     ````
     let singleLineText = "Lorem ipsum dolor sit amet"
     ````

     If the text is too long, a multiline string literal can be used to present longer text:
     ````
     let multilineText = """
     Lorem ipsum dolor sit amet, consectetur
     adipiscing elit, sed do eiusmod. Yay!
     """
     ````
     */
    @discardableResult
    open func showPopupOverlay(text: String, image: UIImage = UIImage()) -> UIView {
        let parentView = setupBlockerView()
        
        let imageView = UIImageView(image: image)
        let label = labelForText(text)
        
        let actualSize = popupSize(forLabel: label, imageView: imageView)
        
        label.frame = label.frame.offsetBy(dx: padding,
                                           dy: imageView.frame.size.height + padding * 2)
        imageView.frame = imageView.frame.offsetBy(dx: (actualSize.width - imageView.frame.size.width)/2,
                                                   dy: padding)
        
        // Container view
        let containerView = buildContainerView(fromSize: actualSize, parentView: parentView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        
        parentView.addSubview(containerView)
        
        containerView.centerViewInSuperview()
        
        containerView.addGestureRecognizer(tapGesture) // Add a tap gesture to dismiss the overlay.
        
        return containerView
    }
    
    /**
     Dismisses the PopupOverlay from the screen.
     
     The PopupOverlay has a tap gesture to dismiss itself automatically, however if needed, it
     can also be dismissed by calling this function. Note that if a reference to the PopupOverlay
     object is not maintained, the PopupOverlay will be deallocated and the built in tap gesture
     won't work.
     */
    @objc open func closePopupOverlay() {
        let parentView = UIApplication.shared.delegate!.window!!
        parentView.subviews
            .filter { $0.tag == containerViewTag }
            .forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Private class methods -
    
    private func labelForText(_ text: String) -> UILabel {
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font as Any])
        
        let labelRect = CGRect(origin: .zero, size: textSize)
        
        let label = UILabel(frame: labelRect)
        label.font = font
        label.textColor = textColor
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }
    
    private func popupSize(forLabel label: UILabel, imageView: UIImageView) -> CGSize {
        let totalWidth = max(imageView.frame.size.width, label.frame.size.width)
        let totalHeight = label.frame.size.height + imageView.frame.size.height
        
        return CGSize(width: totalWidth + padding * 2,
                      height: totalHeight + padding * 3)
    }
    
    private func buildContainerView(fromSize size: CGSize, parentView: UIView) -> UIView {
        let containerViewRect = CGRect(origin: .zero, size: size)
        let containerView = UIView(frame: containerViewRect)
        
        containerView.tag = containerViewTag
        containerView.layer.cornerRadius = cornerRadius
        containerView.backgroundColor = backgroundColor
        containerView.center = CGPoint(
            x: parentView.bounds.size.width/2,
            y: parentView.bounds.size.height/2
        )
        
        return containerView
    }
    
    private func setupBlockerView() -> UIView {
        let window = UIApplication.shared.delegate!.window!!
        
        let blocker = UIView(frame: window.bounds)
        blocker.backgroundColor = backgroundColor
        blocker.tag = containerViewTag
        
        blocker.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(blocker)
        
        let viewsDictionary = ["blocker": blocker]
        
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
        
        return blocker
    }
}

