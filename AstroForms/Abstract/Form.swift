//
//  Form.swift
//  AstroForms
//
//  Created by Andrew Plummer on 4/9/18.
//

import Foundation
import UIKit

typealias VoidCallback = () -> Void

open class Form: UIView, RowDelegate, ValidatableForm {
    
    let scrollView = UIScrollView()
    
    let containerView = UIView()
    
    /// The primary UI stackview for the form.
    let stackView = UIStackView()
    
    /// The rows for the row. Access via the form collection.
    public var rows: [AnyRow] = []
    
    /// Override this function to setup your rows with their initial state.
    /// The base implementation just clears the rows, so it is safe to
    /// call multiple times.
    open func setupRows() {
    
        // Remove all existing rows and views, so this function always refreshes
        //the view entirely.
        rows = []
    
    }

    open func findRow<TagType: Equatable, RowType>(
        tag: TagType
        ) -> RowType? {
        
        for row in self.rows {
            if (row.tag as? TagType) == tag {
                return row as? RowType
            }
        }
        
        return nil
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        initialize()
        setupRows()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        initialize()
        setupRows()
        
    }
    
    open func submit() {
        self.firstResponder?.resignFirstResponder()
    }
    
    // Subclasses cannot override protocol extension of superclasses
    
    open func rowDidStartEditing(row: AnyRow) {}
    
    open func rowDidEndEditing(row: AnyRow) {}
    
    open func rowDidEdit(row: AnyRow) {}
    
    open func rowDidFocus(row: AnyRow) {}
    
    open func rowDidBlur(row: AnyRow) {}
    
    open func rowUpdate(type: RowUpdate, row: AnyRow) { }
    
}
