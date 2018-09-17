//
//  Form.swift
//  AstroForms
//
//  Created by Andrew Plummer on 4/9/18.
//

import Foundation
import UIKit

typealias VoidCallback = () -> Void

open class Form: UIView, RowDelegate {
    
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
        
        let row = self.filter { row -> Bool in
            
            // Confirm a tag match
            guard
                let _tag = row.tag as? TagType,
                _tag == tag
                else { return false }
            
            return true
            
            }.first as? RowType
        
        return row
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initialize()
        setupRows()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        initialize()
        setupRows()
        
    }
    
    open func submit() {}
    
}
