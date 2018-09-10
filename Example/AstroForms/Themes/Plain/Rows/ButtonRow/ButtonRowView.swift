//
//  ButtonRowView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 9/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ButtonRowView: UIView {
    
    weak var row: ButtonRow?
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        row?.buttonTapped()
    }
    
}
