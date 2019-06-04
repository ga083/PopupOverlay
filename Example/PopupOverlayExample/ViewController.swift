//
//  ViewController.swift
//  PopupOverlayExample
//
//  Created by Alexander Solis on 6/2/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let popupOverlay = PopupOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showTextOnlyOverlay() {
        popupOverlay.showPopupOverlay(text: """
Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor
incididunt ut labore et
dolore magna aliqua.

Ut enim ad minim veniam,
quis nostrud exercitation
ullamco laboris nisi ut
aliquip ex ea commodo
consequat.
""")
    }
    
    @IBAction func showTextAndImageOverlay() {
        popupOverlay.showPopupOverlay(text: "Lorem ipsum dolor sit amet!!!",
                                      image: UIImage(named: "Apple")!)
    }
    
    @IBAction func changeOverlayAppearance() {
        popupOverlay.backgroundColor = UIColor.init(red: 0, green: 128, blue: 0, alpha: 0.3)
        popupOverlay.textColor = UIColor.red
        popupOverlay.font = UIFont.systemFont(ofSize: 20.0)
        popupOverlay.padding = CGFloat(30)
        popupOverlay.cornerRadius = CGFloat(30)
    }
    
    @IBAction func resetOverlayAppearance() {
        popupOverlay.setDefaultAppearance()
    }
}

