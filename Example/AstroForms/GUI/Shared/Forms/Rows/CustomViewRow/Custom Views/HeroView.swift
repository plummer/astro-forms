//
//  HeroView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 24/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

final class HeroView: UIView, Themeable, CustomView {
    
    var theme: AstroTheme? = nil
    
    weak var row: CustomViewRow<HeroView>?
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateTheme() {
        imageView.image = image(.astroHero)
        imageView.tintColor = color(.secondaryTint)
        backgroundColor = color(.primaryBackground)
    }
    
}
