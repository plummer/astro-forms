//
//  CheckListRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 12/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class CheckListRow: Row {
    
    typealias View = CheckListRowView
    
    var tag: RowTag
    
    var view: View
    
    func didCheck(newValue: Bool, view: UIView) {
        print("did check \(newValue), \(view)")
    }
    
    func addItem(item: CheckListItemView) {
        item.delegate = self
        view.stackView.addArrangedSubview(item)
    }
    
    init(tag: RowTag) throws {
        
        self.tag = tag
        let view: View = try CheckListRowView.fromXib()
        self.view = view
        
    }
    
    convenience init(tag: RowTag, items: CheckListItemView...) throws {
        
        try self.init(tag: tag)
        items.forEach { addItem(item: $0) }
        
    }
    
}
