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
    
}

public protocol AnyThemeableTraits {
    
    var anyTheme: Theme? { get }
    
    func updateTheme()
    
}

public extension ThemeableTraits {
    
    var anyTheme: Theme? { return theme }
    
}
