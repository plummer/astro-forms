//
//  ValidationRule.swift
//  AstroForms
//
//  Created by Andrew Plummer on 20/9/18.
//

import Foundation

public struct ValidationRule {
    
    public static var isEmail: (String) -> Bool {
        
        return {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(
                with: $0
            )
        }
        
    }
    
}
