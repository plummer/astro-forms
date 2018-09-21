//
//  CheckListRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 12/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class CheckListRow: Row, ValueRow {
    
    var valueHasStartedEditing: Bool = false
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false
    
    typealias Value = [SwitchRow]
    
    typealias View = CheckListRowView
    
    var tag: RowTag
    
    var view: View
    
    var value: Value {
        
        get {
            return rows
        }
        
        set {
            view.stackView.subviews.forEach { $0.removeFromSuperview() }
            newValue.forEach { addItem(item: $0) }
        }
        
    }
    
    var rows: [SwitchRow] = []
    
    func didCheck(newValue: Bool, view: UIView) {
        print("did check \(newValue), \(view)")
    }
    
    func addItem(item: SwitchRow) {
        //item.delegate = self
        rows.append(item)
        view.stackView.addArrangedSubview(item.view)
    }
    
    init(tag: RowTag) throws {
        
        self.tag = tag
        let view: View = try View.fromXib()
        self.view = view
        
    }
    
    convenience init(tag: RowTag, items: [SwitchRow]) throws {
        
        try self.init(tag: tag)
        items.forEach { addItem(item: $0) }
        
    }
    
}
