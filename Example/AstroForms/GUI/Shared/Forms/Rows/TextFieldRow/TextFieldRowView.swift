//
//  TextFieldRowView.swift
//  Astro
//
//  Created by Andrew Plummer on 1/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class TextFieldRowView: UIView,
    UITextFieldDelegate,
    DefaultKeyboardToolbarDelegate, Themeable {
    
    var theme: AstroTheme?
    
    @IBOutlet var textField: AstroTextField!
    
    @IBOutlet var label: UILabel!
    
    weak var row: TextFieldRow?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        textField.delegate = self
        
        textField.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: .editingChanged
        )

    }
    
    func updateTheme() {
        backgroundColor = color(.primaryBackground)
        label.textColor = color(.inputLabelColor)
        textField.textColor = color(.inputTextColor)
        textField.tintColor = color(.primaryTint)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // This will need updating in the event that the form shows / hides
        // a row before / after the TextFieldRow.
        textField.inputAccessoryView = defaultToolbar(row: self.row)
        textField.inputAccessoryView?.tintColor = color(.primaryTint)
        
        return true
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = color(.inputHighlightedBackground)
        
        UIView.animate(withDuration: 0.1) {
           textField.transform = CGAffineTransform.init(scaleX: 1.02, y: 1.02)
        }
        
        row?.valueDidStartEditing()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = color(.inputBackground)
        
        UIView.animate(withDuration: 0.1) {
            textField.transform = CGAffineTransform.init(scaleX: 1.00, y: 1.00)
        }
        
        row?.valueDidEndEditing()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if row?.nextFocusableRow != nil {
            row?.focusChange(.focusNext)
        } else {
            row?.focusChange(.blur)
        }
        
        return true
        
    }
    
    @objc func textFieldDidChange() {

        row?.valueDidEdit()
        
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
    
}
