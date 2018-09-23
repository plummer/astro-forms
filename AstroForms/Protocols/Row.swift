//
//  Row.swift
//  AstroForms
//
//  Created by Andrew Plummer on 4/9/18.
//

import Foundation
import UIKit

/// A basic row, the only requirement is that it has a view.
///
/// Use this type alone if all you want is to display some custom view.
public protocol Row: AnyRow {
    
    associatedtype View: UIView
    
    /// The view for the row, which every row has.
    var view: View { get set }
    
}

/// A type erased version of `Row`
public protocol AnyRow: class {
    
    var baseView: UIView { get }
    
    var form: Form? { get }
    
    func hide(animated: Bool)
    
    func show(animated: Bool)
    
    func showHelper<T: UIView>(view: T)
    
    func hideHelper<T: UIView>(view: T)
    
    var tag: RowTag { get }
    
}

public extension Row {
    
    var baseView: UIView {
        
        get { return view as UIView }
        
    }
    
    func hide(animated: Bool = false) {
        
        guard animated else {
            self.baseView.superview?.alpha = 0
            self.baseView.superview?.isHidden = true
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.baseView.superview?.alpha = 0
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.baseView.superview?.isHidden = true
            self.baseView.superview?.superview?.layoutIfNeeded()
        })
        
    }
    
    func show(animated: Bool = false) {
        
        guard animated else {
            self.baseView.superview?.isHidden = false
            self.baseView.superview?.alpha = 1
            return
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
            self.baseView.superview?.alpha = 1
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.baseView.superview?.isHidden = false
            self.baseView.superview?.alpha = 1
            
            // TODO: iOS 11 specific code. Figure out if it is still required.
            // Breaks in iOS 12.
            //self.superview?.layoutIfNeeded()
            
        })
        
    }
    
    var form: Form? {
        
        var parentForm: Form?
        
        var superview: UIView? = self.baseView.superview
        
        while superview != nil {
            
            if let _form = superview as? Form {
                parentForm = _form
                break
            }
            
            superview = superview?.superview
            
        }
        
        return parentForm
        
    }
    
    // Need to distinguish between showing and adding items
    func showHelper<T: UIView>(view: T) {
        
        // If there is no helper stackview, add it
        guard let topStackView = self.baseView.superview as? UIStackView else {
            return
        }
        
        if topStackView.arrangedSubviews.count == 1 {
            topStackView.addArrangedSubview(UIStackView())
        }
        
        guard let helperStackView = topStackView
            .arrangedSubviews.last as? UIStackView else {
            return
        }
        
        helperStackView.addArrangedSubview(view)
        
    }
    
    func hideHelper<T>(view: T) where T : UIView {
        
        
        
    }
    
}
