//
//  TextViewView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 7/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class TextViewRowView: UIView,
    UITextViewDelegate,
    DefaultKeyboardToolbarDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    weak var row: TextViewRow?
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        // This will need updating in the event that the form shows / hides
        // a row before / after the TextFieldRow.
        textView.inputAccessoryView = defaultToolbar(row: self.row)
        
        return true
        
    }
    
    @objc func keyboardToolbarDoneTapped() {
        
        row?.focusChange(.blur)
        
    }
    
    @objc func keyboardToolbarNextTapped() {
        
        row?.focusChange(.focusNext)
        
    }
    
    @objc func keyboardToolbarPreviousTapped() {
        
        row?.focusChange(.focusPrevious)
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        textView.delegate = self
        
    }
    
}
