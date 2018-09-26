//
//  HintView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 23/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class HintView: UIView, Themeable {
    
    var theme: AstroTheme?
    
    @IBOutlet weak var label: UILabel!
    
    var title: String {
        
        get {  return label.text ?? "" }
        
        set {  label.text = newValue }
        
    }
    
    func updateTheme() {
        backgroundColor = color(.primaryBackground)
        label.textColor = color(.hintTextColor)
    }
    
}
