//
//  PopupOverlay.swift
//  PopupOverlay
//
//  Created by Alexander Solis on 6/2/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import UIKit

open class PopupOverlay {
    public var font: UIFont!
    public var textColor: UIColor!
    public var backgroundColor: UIColor!
    public var cornerRadius: CGFloat!
    public var padding: CGFloat!
    
    private var tapGesture: UITapGestureRecognizer!
    private var swipeRightGesture: UISwipeGestureRecognizer!
    private var swipeLeftGesture: UISwipeGestureRecognizer!
    private var swipeUpGesture: UISwipeGestureRecognizer!
    private var swipeDownGesture: UISwipeGestureRecognizer!
    
    private let tag = 456987123
    
    public init() {
        self.setDefaultAppearance()
        self.setupGestures()
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
        let imageView = UIImageView(image: image)
        let label = UILabel.popupLabel(text: text, font: font, textColor: textColor)
        
        let popupSize = size(label: label, andImage: imageView)
        let popupView = UIView.popupView(size: popupSize,
                                         cornerRadius: cornerRadius,
                                         color: backgroundColor)

        popupView.addSubview(imageView)
        popupView.addSubview(label)
        
        if let overlay = popupView.superview {
            overlay.tag = tag
            addGestures(toView: overlay)
        }
        
        return popupView
    }
    
    /**
     Dismisses the PopupOverlay from the screen.
     
     The PopupOverlay has tap and swipe gestures to dismiss itself automatically, however if needed,
     it can also be dismissed by calling this function. Note that if a reference to the PopupOverlay
     object is not maintained, the PopupOverlay will be deallocated and the built in tap gesture
     won't work.
     */
    @objc open func closePopupOverlay() {
        let parentView = UIApplication.shared.delegate!.window!!
        parentView.subviews
            .filter { $0.tag == tag }
            .forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Private class methods -

    // TODO: this is bad practice, fix it!
    private func size(label: UILabel, andImage imageView: UIImageView) -> CGSize {
        let totalWidth = max(imageView.frame.size.width, label.frame.size.width)
        let totalHeight = label.frame.size.height + imageView.frame.size.height
        
        let actualSize = CGSize(width: totalWidth + padding * 2,
                                height: totalHeight + padding * 3)
        
        label.frame = label.frame.offsetBy(dx: padding,
                                           dy: imageView.frame.size.height + padding * 2)
        imageView.frame = imageView.frame.offsetBy(dx: (actualSize.width - imageView.frame.size.width)/2,
                                                   dy: padding)
        
        return actualSize
    }
    
    private func setupGestures() {
        let closeSelector = #selector(self.closePopupOverlay)
        
        tapGesture = UITapGestureRecognizer(target: self,
                                            action: closeSelector)
        
        swipeRightGesture = UISwipeGestureRecognizer(target: self,
                                                     action: closeSelector)
        
        swipeUpGesture = UISwipeGestureRecognizer(target: self,
                                                  action: closeSelector)
        swipeUpGesture.direction = .up
        
        swipeDownGesture = UISwipeGestureRecognizer(target: self,
                                                    action: closeSelector)
        swipeDownGesture.direction = .down
        
        swipeLeftGesture = UISwipeGestureRecognizer(target: self,
                                                    action: closeSelector)
        swipeLeftGesture.direction = .left
    }
    
    private func addGestures(toView view: UIView) {
        // Add gestures to dismiss the overlay.
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }
}

