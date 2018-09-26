//
//  ThemeabeImageTraits.swift
//  AstroForms
//
//  Created by Andrew Plummer on 26/9/18.
//

import Foundation
import UIKit

public protocol ThemeableImageTraits {
    
    associatedtype ThemeImageType
    
    func image(_ requirement: ThemeImageType) -> UIImage
    
}
