//
//  ValueRow.swift
//  Astro
//
//  Created by Andrew Plummer on 1/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

/// Distinguishes rows with values from those without.
public protocol ValueRow: ValueViewDelegate {
    
    associatedtype Value
    
    /// The value for the row.
    var value: Value { get set }
        
}
