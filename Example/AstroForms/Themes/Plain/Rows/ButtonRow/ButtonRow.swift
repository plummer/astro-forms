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
    
    init(tag: RowTag) throws {
        
        let view: ButtonRowView = try ButtonRowView.fromXib()
        self.view = view
        self.tag = tag
        
    }
    
}
