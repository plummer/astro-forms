//
//  SwitchRowView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 8/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class SwitchRowView: UIView {
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var label: UILabel!
    
    weak var row: SwitchRow?
    
}
