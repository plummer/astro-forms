//
//  LoginViewController.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginFormDelegate {
    
    enum SegueKeys: String {
        case showExampleFields
    }
    
    var theme: AstroTheme = AstroTheme.light

    @IBOutlet weak var loginForm: LoginForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginForm.theme = theme
        loginForm.delegate = self
        
    }
    
    func didSubmit(result: LoginFormData) {
        
        performSegue(
            withIdentifier: SegueKeys.showExampleFields.rawValue,
            sender: result
        )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == SegueKeys.showExampleFields.rawValue {
            
            guard
                let formData = sender as? LoginFormData,
                let dest = segue.destination as? AdditionalInfoViewController
            else {
                return
            }
            
            dest.loginFormData = formData
            
        }
        
    }
    
}
