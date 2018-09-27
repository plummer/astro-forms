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
    
    func showHelper<T: UIView>(
        viewType: T.Type,
        animated: Bool,
        config: ((T) -> Void)?
    )
    
    func hideHelper(
        animated: Bool,
        callback: (() -> Void)?
    )
    
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
    // Limitation at present, a row can only show one helper (although this
    // might be a stackview itself.
    
    
    
    /// Show a helper view with an optional animation.
    ///
    /// - Parameters:
    ///   - viewType: The helper view to show
    ///   - animated: Whether or not to use the default fade in animation
    ///   - config: A block for configuring the new helper
    /// - Throws: An error if the helper cannot be shown
    ///
    /// This method takes a UIView subclass `type`, rather than an instance.
    /// This makes usage easier, particularly for cases where the show
    /// method is called multiple times.
    func showHelper<T: UIView>(
        viewType: T.Type,
        animated: Bool,
        config: ((T) -> Void)?
    ) {
        
        // If there is no helper stackview, add it
        guard let topStackView = self.baseView.superview as? UIStackView else {
            return
        }
        
        let view: T =
            (topStackView.arrangedSubviews.last as? T)
            ?? viewType.fromXib()
        
        view.isHidden = true
        view.alpha = 0
        
        func animateAndConfigureNewView(animated: Bool) {
            
            // Add the view if it doesn't exist
            let viewExists = topStackView.arrangedSubviews.count > 1

            config?(view)
            
            if !viewExists {
                topStackView.addArrangedSubview(view)
            } else {
                view.isHidden = false
                view.alpha = 1
                return
            }
            
            (view as? ThemeableView)?.updateTheme()
            
            guard animated else {
                view.isHidden = false
                view.alpha = 1
                return
            }

            UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
                view.alpha = 1
            })
            
            UIView.animate(withDuration: 0.3, animations: {
                view.isHidden = false
                view.alpha = 1
                
                // TODO: iOS 11 specific code. Figure out if it is still required.
                // Breaks in iOS 12.
                //view.superview?.layoutIfNeeded()
                
            })
            
        }
        
        let lastViewOfDifferentType: UIView? =
            topStackView.arrangedSubviews.count > 1
            && topStackView.arrangedSubviews.last as? T == nil
                ? topStackView.arrangedSubviews.last
                : nil
        
        if lastViewOfDifferentType != nil {
            
            hideHelper(animated: animated) {
                animateAndConfigureNewView(animated: animated)
            }

        } else {
            animateAndConfigureNewView(animated: animated)
        }
        
    }
    
    func hideHelper(animated: Bool = false, callback: (() -> Void)? = nil) {
        
        guard let topStackView = self.baseView.superview as? UIStackView else {
            return
        }
        
        guard
            topStackView.arrangedSubviews.count > 1,
            let helperView = topStackView.arrangedSubviews.last else {
                    return
        }
        
        guard animated else {
            helperView.alpha = 0
            helperView.isHidden = true
            topStackView.removeArrangedSubview(helperView)
            helperView.removeFromSuperview()
            callback?()
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            helperView.alpha = 0
            
        }) { _ in
            
            UIView.animate(withDuration: 0.2, animations: {
                
                helperView.isHidden = true
                
            }, completion: { _ in
                
                DispatchQueue.main.async {
                    topStackView.removeArrangedSubview(helperView)
                    helperView.removeFromSuperview()
                    callback?()
                }
                
            })
            
        }
        
    }
    
}
