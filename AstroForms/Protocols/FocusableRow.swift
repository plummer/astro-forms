//
//  FocusableRow.swift
//  Astro
//
//  Created by Andrew Plummer on 24/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

public protocol FocusableRow {
    
    /// An offset modifier for keyboard management.
    ///
    /// Use this to have a custom focus rect when row is being edited.
    var focusRect: CGRect { get }

    var focusElement: UIResponder { get }
    
    var nextFocusableRow: FocusableRow? { get }
    
    var previousFocusableRow: FocusableRow? { get }
    
    func focusChange(_ change: FocusChange)
    
}

public extension AnyRow where Self: FocusableRow {
    
    var focusRect: CGRect { return self.baseView.frame }
    
}

public extension AnyRow where Self: FocusableRow {
    
    func focusChange(_ change: FocusChange) {
        
        switch change {
        case .focus:
            focusElement.becomeFirstResponder()
        case .focusNext:
            nextFocusableRow?.focusChange(.focus)
        case .focusPrevious:
            previousFocusableRow?.focusChange(.focus)
        case .blur:
            focusElement.resignFirstResponder()
        }
        
    }
    
    private func getNextFocusableRow(
        currentRow: AnyRow,
        reversedDirection: Bool = false
    ) -> FocusableRow? {
        
        guard let _form = form else { return nil }
        
        var passedCurrentRow = false
        
        for index in stride(
            from: reversedDirection ? _form.endIndex - 1 : _form.startIndex,
            to: reversedDirection ? _form.startIndex - 1 : _form.endIndex,
            by: reversedDirection ? -1 : 1
            ) {
                
                // If the baseView refers to the same instance then
                // this is the same row.
                if _form[index].baseView === self.baseView {
                    passedCurrentRow = true
                    continue
                }
                
                guard passedCurrentRow == true else {
                    continue
                }
                
                guard let _focusableRow = _form[index] as? FocusableRow else {
                    continue
                }
                
                return _focusableRow
                
        }
        
        return nil
        
    }
    
    var previousFocusableRow: FocusableRow? {
        return getNextFocusableRow(currentRow: self, reversedDirection: true)
    }
    
    var nextFocusableRow: FocusableRow? {
        return getNextFocusableRow(currentRow: self, reversedDirection: false)
    }
    
}


