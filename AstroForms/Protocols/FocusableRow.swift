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
    /// If you implement this as nil, the frame of the `baseView` will be
    /// focused by default. Computes lazily so that it will be accessed
    /// when the row is actually being focused.
    var focusRect: () -> CGRect? { get set }

    /// The UIResponder element to focus when the Next / Previous keyboard
    /// buttons are tapped, or the row is otherwise given focus.
    var focusElement: UIResponder { get }
    
    /// The next row in the form, if it exists.
    var nextFocusableRow: FocusableRow? { get }
    
    /// The previous row in the form, if it exists.
    var previousFocusableRow: FocusableRow? { get }
    
    /// Change the focus state of this row.
    ///
    /// - Parameter change: The type of focus update.
    func focusChange(_ change: FocusChange)
    
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
    
    /// Get the row before or after a given row.
    ///
    /// - Parameters:
    ///   - currentRow: The row to check before / after for.
    ///   - reversedDirection: Check in the reverse direction
    /// - Returns: The row before / after the given row
    ///
    /// Use the computed variables `nextFocusableRow` and `previousFocusableRow`
    /// instead of this function.
    private func nextFocusableRow(
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
        return nextFocusableRow(currentRow: self, reversedDirection: true)
    }
    
    var nextFocusableRow: FocusableRow? {
        return nextFocusableRow(currentRow: self, reversedDirection: false)
    }
    
}


