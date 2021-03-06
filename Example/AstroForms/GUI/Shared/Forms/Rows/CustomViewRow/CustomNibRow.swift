//
//  CustomViewRow
//  AstroForms_Example
//
//  Created by Andrew Plummer on 24/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class CustomViewRow<T>: Row where T: CustomView {

    typealias View = T
    
    var view: T
    
    var tag: RowTag
    
    init(tag: RowTag, config: ((CustomViewRow) -> Void)? = nil) {
        
        let view: T = T.fromXib()
        self.tag = tag
        self.view = view
        self.view.row = self
        config?(self)
        
    }
    
}
