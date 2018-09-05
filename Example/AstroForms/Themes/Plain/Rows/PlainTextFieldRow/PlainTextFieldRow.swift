//
//  FieldRow.swift
//  Astro
//
//  Created by Andrew Plummer on 1/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

/// A basic text field and label row.
class PlainTextFieldRow: Row, ValueRow, FocusableRow {
    
    typealias Value = String?
    
    var tag: RowTag
    
    var view: PlainTextFieldView
    
    var focusElement: UIResponder { return view.textField }
    
    /// The `UITextField` input value.
    var value: Value {
        
        get { return view.textField.text }
        
        set { view.textField.text = newValue }
        
    }
    
    /// The `UITextField` placeholder text.
    var placeholder: Value {
        
        get { return view.textField.placeholder }
        
        set { view.textField.placeholder = newValue }
        
    }
    
    /// The `UILabel` above the text field.
    var title: String? {
        
        get { return view.label.text }
        
        set { view.label.text = newValue }
        
    }

    var keyboardType: UIKeyboardType {
        
        get { return view.textField.keyboardType }
        
        set { view.textField.keyboardType = newValue }
        
    }
    
    var isSecureTextEntry: Bool {
        
        get { return view.textField.isSecureTextEntry }
        
        set { view.textField.isSecureTextEntry = newValue }
        
    }
    
    var clearButtonMode: UITextField.ViewMode {
        
        get { return view.textField.clearButtonMode }
        
        set { view.textField.clearButtonMode = newValue }
        
    }
    
    convenience init(
        tag: RowTag,
        title: String? = nil,
        value: String? = nil,
        placeholder: String? = nil,
        keyboardType: UIKeyboardType = UIKeyboardType.default,
        isSecureTextEntry: Bool = false,
        clearButtonMode: UITextField.ViewMode = UITextField.ViewMode.never
    ) throws {
        
        try self.init(tag: tag)
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self.clearButtonMode = clearButtonMode

    }
    
    init(tag: RowTag) throws {
        
        let view: PlainTextFieldView = try PlainTextFieldView.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        
    }
    
    func valueDidEndEditing() {
        
    }
    
}
