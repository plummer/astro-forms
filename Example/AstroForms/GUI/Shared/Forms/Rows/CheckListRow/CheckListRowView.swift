//
//  CheckListRowView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 12/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CheckListRowView: UIView, Themeable {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var checkListBackground: UIView!
    
    var theme: AstroTheme?
    
    func updateTheme() {
        
        backgroundColor = color(.primaryBackground)
        checkListBackground.backgroundColor = color(.inputBackground)
        label.textColor = color(.inputLabelColor)
        
        stackView.arrangedSubviews.forEach {
            ($0 as? CheckListRowItemView)?.updateTheme()
        }
        
    }
    
}
