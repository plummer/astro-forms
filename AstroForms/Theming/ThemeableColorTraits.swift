//
//  ThemeableColorTraits.swift
//  AstroForms
//
//  Created by Andrew Plummer on 25/9/18.
//

import Foundation
import UIKit

/// There traits of having a themeable color scheme, for Themeable
public protocol ThemeableColorTraits {
    
    associatedtype ThemeColorType
    
    func color(_ requirement: ThemeColorType) -> UIColor
    
}

public protocol ThemeableImageTraits {
    
    associatedtype ThemeImageType
    
    func image(_ requirement: ThemeImageType) -> UIImage
    
}
