//
//  LoginViewController.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    let theme: AstroTheme = AstroTheme.normal
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var backgroundImageView: ThemeableImageView!
    @IBOutlet weak var loginForm: LoginForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginForm.theme = theme
        backgroundImageView.theme = theme

        
    }
    
}
