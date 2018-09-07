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
    DefaultKeyboardToolbarDelegate {
    
    @IBOutlet var textField: UITextField!
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // This will need updating in the event that the form shows / hides
        // a row before / after the TextFieldRow.
        textField.inputAccessoryView = defaultToolbar(row: self.row)
        
        return true
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        row?.valueDidStartEditing()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
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
