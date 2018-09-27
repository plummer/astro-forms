//
//  ExampleFieldsViewController.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ExampleFieldsViewController: UIViewController {
    
    @IBOutlet weak var exampleFieldsForm: ExampleFieldsForm!
    
    var loginFormData: LoginFormData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleFieldsForm.loginFormData = loginFormData
    }
    
}
