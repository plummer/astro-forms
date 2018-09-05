//
//  TextFieldView.swift
//  Astro
//
//  Created by Andrew Plummer on 1/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation
import UIKit

class PlainTextFieldView: UIView, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    weak var row: PlainTextFieldRow?
    
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
        
        textField.inputAccessoryView = defaultToolbar
        
        return true
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        row?.valueDidStartEditing()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        row?.valueDidEndEditing()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        row?.focusChange(.focusNext)
        
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
    
    var defaultToolbar: UIToolbar {
       
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarDoneTapped)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarNextTapped)
        )
        
        let previousButton = UIBarButtonItem(
            title: "Previous",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarPreviousTapped)
        )
        
        toolbar.setItems([
                previousButton,
                nextButton,
                flexibleSpace,
                doneButton
            ], animated: false
        )
        
        return toolbar
        
    }
    
}
