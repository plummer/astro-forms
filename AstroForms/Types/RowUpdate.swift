//
//  RowUpdate.swift
//  AstroForms
//
//  Created by Andrew Plummer on 23/9/18.
//

import Foundation

public enum RowUpdate {
    case
    
    /// Every time the row is changed
    live,
    
    /// Each time the row is blurred
    onResignActive,
    
    /// On blur after the row has changed at least once
    onResignActiveAfterChange,
    
    /// Confusing to name, but live changes after blur, and on the initial
    /// blur event if the form has changed
    regular
    
}
