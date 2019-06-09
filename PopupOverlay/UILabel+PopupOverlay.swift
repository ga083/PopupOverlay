//
//  UILabel+PopupOverlay.swift
//  Pods-PopupOverlayExample
//
//  Created by Alexander Solis on 6/8/19.
//

import UIKit

extension UILabel {
    static func popupLabel(text: String,
                           font: UIFont,
                           textColor: UIColor) -> UILabel {
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
}
