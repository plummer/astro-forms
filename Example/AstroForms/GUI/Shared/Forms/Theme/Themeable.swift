//
//  Themeable.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 25/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

/// An implementation interface that binds theming associated types
/// to concrete types with generic constraints.
protocol Themeable:
    ThemeableColorTraits,
    ThemeableImageTraits,
    ThemeableTraits,
    ThemeableView
    where
        ThemeType == AstroTheme,
        ThemeColorType == AstroThemeColor,
        ThemeImageType == AstroThemeImage {
    // This protocol does nothing except specify the types for `Theme` and
    // consolidate the various types of theming that are required in a given
    // project, so that a concrete type only needs implement one protocol
    // for theming.
    
    func getTheme() -> ThemeType
    
}

extension Themeable where Self: UIView {
    func updateTheme() {
        
    }
}

extension Themeable where Self: Form {
    
    // Forms don't have updates themselves, but instead update child views.
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

extension Themeable where Self: UIView {
    
    func getTheme() -> ThemeType {
        
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
        
        let theme: ThemeType =
            self.theme
                ?? (parentForm as? AnyThemeableTraits)?.anyTheme as? ThemeType
                ?? .normal
        
        return theme
        
    }

}
