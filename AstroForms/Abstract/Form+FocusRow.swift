//
//  Form+FocusRow.swift
//  Astro
//
//  Created by Andrew Plummer on 24/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

extension Form {
    
    /// Scroll to a focused row's preferred focus rect if there is an active
    /// first responder inside it.
    func focusRow() {
        
        guard
            let focusableRow = rows.filter({ row -> Bool in
                return
                    row.baseView.firstResponder != nil
                    && (row as? FocusableRow) != nil
        }).first as? FocusableRow,
            let row = focusableRow as? AnyRow else {
                return
        }
        
        // TODO: Convert to the window coordinate space
        let focusRect = focusableRow.focusRect() ?? row.baseView.frame
        
        var view: UIView? = row.baseView
        
        var scrollView: UIScrollView?
        
        while scrollView == nil {
            
            guard let _superview = view?.superview else { break }
            scrollView = _superview as? UIScrollView
            view = _superview
            
        }
        
        guard
            let _scrollView = scrollView,
            let _directSuperview = row.baseView.superview else { return }
        
        let rectInScrollView = _directSuperview.convert(
            focusRect,
            to: _scrollView
        )
        
        _scrollView.scrollRectToVisible(
            rectInScrollView,
            animated: true
        )
        
    }
    
}
