//
//  BackgroundContainerViewController.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BackgroundViewController: UIViewController {
    
    let theme: AstroTheme = AstroTheme.light
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var backgroundImageView: ThemeableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.theme = theme
    }
    
}
