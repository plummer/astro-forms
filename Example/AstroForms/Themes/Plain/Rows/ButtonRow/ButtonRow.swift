//
//  ButtonRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 9/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class ButtonRow: Row {
    
    var view: ButtonRowView
    
    typealias View = ButtonRowView
    
    var tag: RowTag
    
    var buttonTapBlock: (() -> Void)?
    
    func buttonTapped() {
        buttonTapBlock?()
    }
    
    var title: String? {
        get {
            return view.button.titleLabel?.text
        }
        set {
            view.button.titleLabel?.text = newValue
        }
    }
    
    init(tag: RowTag, config: ((ButtonRow) -> Void)? = nil) {
        
        let view: View = View.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        config?(self)
        
    }
    
}
