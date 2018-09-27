//
//  ExampleFieldsForm.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class ExampleFieldsForm: Form, Themeable {
    
    var loginFormData: LoginFormData? {
        didSet {
            if let _loginFormData = loginFormData {
                setupForm(loginFormData: _loginFormData)
            }
        }
    }
    
    var theme: AstroTheme? = .light {
        didSet {
            updateTheme()
        }
    }
    
    func setupForm(loginFormData: LoginFormData) {
        
        
        
    }

}
