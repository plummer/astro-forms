//
//  AstroTextField.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 25/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

// This implementation uses a UITextField subclass just to allow inset changes
@IBDesignable
class AstroTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
