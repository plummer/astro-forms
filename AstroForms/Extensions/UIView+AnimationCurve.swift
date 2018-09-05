//
//  UIView+AnimationCurve.swift
//  Astro
//
//  Created by Andrew Plummer on 6/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

extension UIView.AnimationCurve {
    
    /// Converts a `UIView.AnimationCurve` into `UIView.AnimationOptions`
    /// as required by `UIView.animateWithDuration` when the curve
    /// is the only animation option.
    ///
    /// - Returns: THe `UIView.AnimationOptions` of a `UIView.AnimationCurve`
    func toOptions() -> UIView.AnimationOptions {
        
        return UIView.AnimationOptions(rawValue: UInt(rawValue << 16))
        
    }
    
}
