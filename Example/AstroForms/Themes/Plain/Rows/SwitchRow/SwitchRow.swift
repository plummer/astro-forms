//
//  SwitchRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 8/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class SwitchRow: Row, ValueRow {
    
    var valueHasStartedEditing: Bool = false
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false
    
    typealias Value = Bool
    
    var tag: RowTag
    
    var view: SwitchRowView
    
    var value: Value {
        
        get { return view.switch.isOn }
        
        set { view.switch.setOn(newValue, animated: false) }
        
    }
    
    init(tag: RowTag, config: ((SwitchRow) -> Void)? = nil) {
        
        let view: View = View.fromXib()
        self.view = view
        self.tag = tag
        self.view.row = self
        config?(self)
        self.view.switch.accessibilityLabel = self.view.label.text
        
    }
    
}
