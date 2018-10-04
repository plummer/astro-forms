//
//  AstroThemeImage.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum AstroThemeImage {
    
    case
        formBackground,
        astroHero
    
}

extension Themeable {
    func image(_ requirement: ThemeImageType) -> UIImage {
        
        let theme = getTheme() ?? .normal
        
        switch theme  {
            
        case .normal:
            
            switch requirement {
                
            case .formBackground: return UIImage.from(color: .white)
                
            case .astroHero:
                let image = #imageLiteral(resourceName: "Astro Hero").withRenderingMode(.alwaysTemplate)
                return image
            }
            
        case .grey:
            
            switch requirement {
                
            case .formBackground: return UIImage.from(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                
            case .astroHero:
                let image = #imageLiteral(resourceName: "Astro Hero").withRenderingMode(.alwaysTemplate)
                return image
            }
            
        case .light:
            
            switch requirement {
                
            case .formBackground: return #imageLiteral(resourceName: "Astro Background")
                
            case .astroHero: return #imageLiteral(resourceName: "Astro Hero")
                
            }
            
        }
        
    }
}
