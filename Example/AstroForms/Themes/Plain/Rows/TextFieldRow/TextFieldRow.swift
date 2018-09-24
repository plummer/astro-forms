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
class TextFieldRow: Row, ValueRow, FocusableRow, RowUpdateResponder {
    
    var valueHasStartedEditing: Bool = false
    
    var onRowUpdate: ((RowUpdate) -> Void)? = nil
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false
    
    var focusRect: () -> CGRect? = { return nil }
    
    typealias Value = String
    
    var tag: RowTag
    
    var view: TextFieldRowView

    var focusElement: UIResponder { return view.textField }
    
    /// The `UITextField` input value.
    var value: Value {
        
        get {  return view.textField.text ?? "" }
        
        set { view.textField.text = newValue }
        
    }
    
    init(tag: RowTag, config: ((TextFieldRow) -> Void)? = nil) {
        
        let view: View = View.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        
        config?(self)
        
        self.view.textField.accessibilityLabel = self.view.label.text ?? ""
        
    }
    
}
