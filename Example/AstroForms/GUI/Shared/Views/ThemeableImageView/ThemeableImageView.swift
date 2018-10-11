//
//  ThemeableImageView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

/// A UIImageView that conforms to the project Themeable protocol.
class ThemeableImageView: UIImageView, Themeable {
    
    var theme: AstroTheme? {
        didSet { updateTheme() }
    }
    
    func updateTheme() { self.image = image(.formBackground) }
    
}
