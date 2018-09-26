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
    
    var theme: AstroTheme? = nil
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var label: UILabel!
    
    weak var row: SwitchRow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        `switch`.addTarget(
            self,
            action: #selector(switchValueChanged(_:)),
            for: .valueChanged
        )
        
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        row?.valueDidEndEditing()
    }
    
}
