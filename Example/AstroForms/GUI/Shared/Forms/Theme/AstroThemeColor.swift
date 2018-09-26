//
//  AstroThemeColor.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 25/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum AstroThemeColor {
    case
    
        /// The primary tint color for the form
        primaryTint,
    
        /// For two-tone themes, another tint color
        secondaryTint,
    
        /// The background for rows
        primaryBackground,
    
        /// UIButton
        buttonBackground,
        buttonDisabledBackground,
        buttonHighlightedBackground,
    
        // UITextField, UITextArea
        inputBackground,
        inputDisabledBackground,
        inputHighlightedBackground,
        inputTextColor,
        inputLabelColor,
    
        // Helpers
        errorTextColor,
        hintTextColor
    
}

extension Themeable {
    
    func color(_ requirement: ThemeColorType) -> UIColor {
        
        let theme = getTheme()
        
        switch theme {
            
        case .normal:
            
            switch requirement {
                
            case .primaryTint: return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                
            case .secondaryTint: return self.color(.primaryTint)
                
            case .primaryBackground: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            case .inputBackground: return #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
                
            case .inputDisabledBackground: return #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
                
            case .inputHighlightedBackground: return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
                
            case .buttonBackground: return self.color(.primaryTint)
                
            case .buttonDisabledBackground: return #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
                
            case .buttonHighlightedBackground: return #colorLiteral(red: 0, green: 0.3920759949, blue: 0.8128569162, alpha: 1)
                
            case .inputTextColor: return .black
                
            case .inputLabelColor: return .black
                
            case .errorTextColor: return #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                
            case .hintTextColor: return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                
            }
            
        case .grey:
            
            switch requirement {
                
            case .primaryTint: return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                
            case .secondaryTint: return self.color(.primaryTint)
                
            case .primaryBackground: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            case .inputBackground: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            case .inputDisabledBackground: return #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
                
            case .inputHighlightedBackground: return #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                
            case .buttonBackground: return self.color(.primaryTint)
                
            case .buttonDisabledBackground: return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            case .buttonHighlightedBackground: return #colorLiteral(red: 0, green: 0.3970302654, blue: 0.8231281726, alpha: 1)
            
            case .inputTextColor: return .black
                
            case .inputLabelColor: return .black
                
            case .errorTextColor: return #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                
            case .hintTextColor: return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                
            }
            
        case .light:
            
            switch requirement {
                
            case .primaryTint: return #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 1)
                
            case .secondaryTint: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            case .primaryBackground: return UIColor.clear
                
            case .inputBackground: return #colorLiteral(red: 0.8847963012, green: 0.8847963012, blue: 0.8847963012, alpha: 1)
                
            case .inputDisabledBackground: return #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
                
            case .inputHighlightedBackground: return #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                
            case .buttonBackground: return self.color(.primaryTint)
                
            case .buttonDisabledBackground: return #colorLiteral(red: 0.246659416, green: 0.03052198005, blue: 0.4460903286, alpha: 1)
                
            case .buttonHighlightedBackground: return #colorLiteral(red: 0.598350899, green: 0.1961166696, blue: 1, alpha: 1)
                
            case .inputTextColor: return .black
                
            case .inputLabelColor: return .white
                
            case .errorTextColor: return .white
                
            case .hintTextColor: return .white
                
            }
            
        }
        
    }
    
}
