//
//  CheckListItemView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 17/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CheckListItemView: UIView {
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: CheckListRow?
    
    var isChecked: Bool {
        get {
            return `switch`.isOn
        }
        set {
            `switch`.setOn(newValue, animated: true)
            delegate?.didCheck(newValue: newValue, view: self)
        }
    }
    
    static func initFromNibWithValue(
        label: String,
        value: Bool
    ) throws -> CheckListItemView {
        
        let view: CheckListItemView = try CheckListItemView.fromXib()
        
        view.label.text = label
        view.`switch`.setOn(value, animated: false)
        
        return view
        
    }
    
}
