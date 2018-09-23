//
//  RowDelegate.swift
//  AstroForms
//
//  Created by Andrew Plummer on 17/9/18.
//

import Foundation

public protocol RowDelegate {
    
    func rowDidStartEditing(row: AnyRow)
    
    func rowDidEndEditing(row: AnyRow)
    
    func rowDidEdit(row: AnyRow)
    
    func rowDidFocus(row: AnyRow)
    
    func rowDidBlur(row: AnyRow)
    
    func rowUpdate(type: RowUpdate, row: AnyRow)
    
}
