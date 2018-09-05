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
    
}

public extension ValueViewDelegate {
    
    func valueDidEdit() {}
    
    func valueDidStartEditing() {}
    
    func valueDidEndEditing() {}
    
}

public extension ValueViewDelegate where Self: AnyRow {
    
    func valueDidEdit() {
        form?.rowDidEdit(row: self)
    }
    
    func valueDidStartEditing() {
        form?.rowDidStartEditing(row: self)
    }
    
    func valueDidEndEditing() {
        form?.rowDidEndEditing(row: self)
    }
    
}
