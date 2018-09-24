//
//  RowUpdateResponder.swift
//  AstroForms
//
//  Created by Andrew Plummer on 23/9/18.
//

import Foundation

public protocol RowUpdateResponder {
    
    var onRowUpdate: ((RowUpdate) -> Void)? { get set }
    
}
