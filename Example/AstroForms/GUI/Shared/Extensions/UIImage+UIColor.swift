//
//  UIImage+UIColor.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 25/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
}
