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
    
    var valueHasStartedEditing: Bool = false
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false

    var focusRect: () -> CGRect? = { nil }
    
    typealias Value = String
    
    var tag: RowTag
    
    var view: TextViewRowView
    
    var focusElement: UIResponder { return view.textView }
    
    var value: Value {
        
        get { return view.textView.text }
        
        set { view.textView.text = newValue }
        
    }
    
    var height: CGFloat {
        
        get { return view.textViewHeightConstraint.constant }
        
        set { view.textViewHeightConstraint.constant = newValue }
        
    }
    
    init(tag: RowTag, config: ((TextViewRow) -> Void)? = nil) {
        
        let view: View = View.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        config?(self)
        self.view.textView.accessibilityLabel = self.view.label.text ?? ""
        
    }

}
