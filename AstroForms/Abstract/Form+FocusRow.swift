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
    func focusRow(duration: Double, options: UIView.AnimationOptions) {
        
        for row in rows {
            
            // Check if this is the currently selected row
            guard
                row.baseView.firstResponder != nil,
                let focusableRow = row as? FocusableRow else { continue }

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
                let _directSuperview = row.baseView.superview else { continue }
            
            let rectInScrollView = _directSuperview.convert(
                focusRect,
                to: _scrollView
            )
            
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: options,
                animations: {
                // The animated property can't be used here, so this is
                // wrapping in a standard UIView animation. If you use the
                // animation property, it will conflict with the built in
                // `UITextField` focus behaviour of UIKit, and will only
                // work sometimes. Incidentally this provides more control over
                // the focus timing / curve.
                _scrollView.scrollRectToVisible(
                    rectInScrollView,
                    animated: false
                )
            }, completion: nil)
            
        }
        
    }
    
}
