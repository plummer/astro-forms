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
    
}
