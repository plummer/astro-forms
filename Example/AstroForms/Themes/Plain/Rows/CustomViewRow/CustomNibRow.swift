//
//  CustomNibRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 24/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class CustomNibRow<T: UIView>: Row {
    
    typealias View = T
    
    var view: T
    
    var tag: RowTag
    
    init(tag: RowTag, config: ((CustomNibRow) -> Void)? = nil) {
        
        let view: T = T.fromXib()
        self.tag = tag
        self.view = view
        config?(self)
        
    }
    
}
