//
//  UIView+XibInitializable.swift
//  Astro
//
//  Created by Andrew Plummer on 1/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Creates a UIView from a nib.
    ///
    ///
    /// - Returns: The UIView from Xib
    /// - Throws: An error if the view couldn't be instantiated.
    ///
    /// To use a subclass, add the type annotation.
    /// i.e. `let subclass: SubclassUIView = try SubclassUIView.fromXib()`
    public static func fromXib<T: UIView>() -> T {
        
        guard
            let nib = Bundle.main.loadNibNamed(
                String(describing: T.self),
                owner: nil,
                options: nil
                )?.first,
            let view = nib as? T else {
                
                fatalError(
                    """
                    ---
                    🚨 Fatal Error: Attempt to instantiate Nib:
                    \(String(describing: T.self)) however it does not exist.
                    ---
                    """
                )
                
        }
        
        return view
        
    }
    
}
