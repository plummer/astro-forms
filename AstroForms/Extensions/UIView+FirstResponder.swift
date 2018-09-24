//
//  UIView+FirstResponder.swift
//  Astro
//
//  Created by Andrew Plummer on 24/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

extension UIView {
    
    /// The first responder within this view's tree of views if it exists.
    public var firstResponder: UIView? {
        
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
        
    }
    
}
