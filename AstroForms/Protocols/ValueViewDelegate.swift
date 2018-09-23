//
//  ValueViewDelegate.swift
//  Astro
//
//  Created by Andrew Plummer on 2/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation

/// Optional delegate methods for views with changing values
public protocol ValueViewDelegate: class {
    
    func valueDidEdit()
    
    func valueDidStartEditing()
    
    func valueDidEndEditing()
    
    var valueHasChanged: Bool { get set }
    
    var valueHasEndedEditing: Bool { get set }
    
    var valueHasStartedEditing: Bool { get set }
    
}

public extension ValueViewDelegate where Self: AnyRow {

    func valueDidEdit() {
        
        form?.rowDidEdit(row: self)
        self.valueHasChanged = true
        
        form?.rowUpdate(type: .live, row: self)
        
        if valueHasEndedEditing {
            form?.rowUpdate(type: .regular, row: self)
        }
        
    }
    
    func valueDidStartEditing() {
        
        form?.rowDidStartEditing(row: self)
        self.valueHasStartedEditing = true
        
    }
    
    func valueDidEndEditing() {
        
        form?.rowDidEndEditing(row: self)
        self.valueHasEndedEditing = true
        
        form?.rowUpdate(type: .onResignActive, row: self)
        
        if valueHasChanged {
            form?.rowUpdate(type: .onResignActiveAfterChange, row: self)
            form?.rowUpdate(type: .regular, row: self)
        }
        
    }
    
}
