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
    DefaultKeyboardToolbarDelegate, Themeable {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var theme: AstroTheme?
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    weak var row: TextViewRow?
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        // This will need updating in the event that the form shows / hides
        // a row before / after the TextFieldRow.
        textView.inputAccessoryView = defaultToolbar(row: self.row)
        textView.inputAccessoryView?.tintColor = color(.primaryTint)
        
        return true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        row?.valueDidStartEditing()
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        row?.valueDidEndEditing()
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
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
    
    func updateTheme() {
        
        backgroundColor = color(.primaryBackground)
        label.textColor = color(.inputLabelColor)
        textView.textColor = color(.inputTextColor)
        textView.tintColor = color(.primaryTint)
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(
            top: 12,
            left: 8,
            bottom: 12,
            right: 8
        )
        
    }
    
}
