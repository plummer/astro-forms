//
//  TextViewRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 7/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class TextViewRow: Row, ValueRow, FocusableRow {

    var focusRect: () -> CGRect? = { return nil }
    
    typealias Value = String?
    
    var tag: RowTag
    
    var view: TextViewRowView
    
    var focusElement: UIResponder { return view.textView }
    
    var value: Value {
        
        get {
            
            // Normalise the behaviour of an empty view with `UITextField`
            return view.textView.text.count > 0
                ? view.textView.text
                : nil
            
        }
        
        set { view.textView.text = newValue }
        
    }
    
    var title: String? {
        
        get { return view.label.text }
        
        set { view.label.text = newValue }
        
    }
    
    var keyboardType: UIKeyboardType {
        
        get { return view.textView.keyboardType }
        
        set { view.textView.keyboardType = newValue }
        
    }
    
    var isSecureTextEntry: Bool {
        
        get { return view.textView.isSecureTextEntry }
        
        set { view.textView.isSecureTextEntry = newValue }
        
    }
    
    init(tag: RowTag) throws {
        
        let view: TextViewRowView = try TextViewRowView.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        
    }

}
