//
//  ThemeableTraits.swift
//  AstroForms
//
//  Created by Andrew Plummer on 25/9/18.
//

import Foundation
import UIKit

public protocol Theme { }

/// The traits of having a theme associated.
public protocol ThemeableTraits: AnyThemeableTraits {
    
    associatedtype ThemeType: Theme
    
    var theme: ThemeType? { get }
    
    func getTheme() -> ThemeType?
    
}

public protocol AnyThemeableTraits {
    
    var anyTheme: Theme? { get }
    
    func updateTheme()
    
}

public extension ThemeableTraits {
    
    var anyTheme: Theme? { return theme }
    
}

public extension ThemeableTraits where Self: UIView {
    
    func updateTheme() { }
    
    func getTheme() -> ThemeType? {
        
        var parentForm: Form?
        
        // Shortcut the loop if the current view is a form
        // This prevents a form inheriting from a parent for styles
        // however that doesn't seem like a reasonable case.
        var superview: UIView? = (self as? Form) ?? self.superview
        
        // This is convenient but slow (On^2 for n rows)
        // TODO: Look at changing the way form is referenced generally
        // to speed this up if necessary.
        
        while superview != nil {
            
            if let _form = superview as? Form {
                parentForm = _form
                break
            }
            
            superview = superview?.superview
            
        }
        
        let theme: ThemeType? =
            self.theme
                ?? (parentForm as? AnyThemeableTraits)?.anyTheme as? ThemeType
        
        return theme
        
    }
    
}

public extension ThemeableTraits where Self: Form {
    
    func updateTheme() {
        
        func updateSubviews(for view: UIView) {
            for view in view.subviews {
                (view as? ThemeableView)?.updateTheme()
                updateSubviews(for: view)
            }
        }
        
        updateSubviews(for: self)
        
    }
    
}
