//
//  CheckListRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 12/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class CheckListRow: Row, ValueRow, CheckListRowItemViewDelegate {
    
    var valueHasStartedEditing: Bool = false
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false
    
    typealias Value = [Bool]
    
    typealias View = CheckListRowView
    
    var tag: RowTag
    
    var view: View
    
    enum SelectionType {
        case single, multiple
    }
    
    var selectionType: SelectionType = .single
    
    var value: Value {
        get {
            
            let views = view.stackView.arrangedSubviews.compactMap {
                view -> CheckListRowItemView? in
                return view as? CheckListRowItemView
            }
            
            return views.map({ return $0.isChecked })
            
        }
        set {
            
            let views = view.stackView.arrangedSubviews.compactMap {
                view -> CheckListRowItemView? in
                return view as? CheckListRowItemView
            }
            
            for (i, value) in newValue.enumerated() {
                if views.indices.contains(i) {
                    views[i].isChecked = value
                }
            }
            
        }
    }
    
    func didCheck(newValue: Bool, view: UIView) {
        print("did check \(newValue), \(view)")
    }
    
    func addItems(labels: [String]) {
        
        for (i, label) in labels.enumerated() {
            
            let item: CheckListRowItemView = CheckListRowItemView.fromXib()
            
            item.label.text = label
            
            view.stackView.addArrangedSubview(item)
            
            item.updateTheme()
            
            item.delegate = self
            
            switch i {
            case 0:
                item.listPosition = labels.count == 0 ? .single : .start
            case labels.count - 1:
                item.listPosition = .end
            default:
                item.listPosition = .middle
            }
            
        }
        
    }
    
    func willSelect(_ view: CheckListRowItemView) {
        
        switch selectionType {
        case .single:
            self.view.stackView.arrangedSubviews
                .filter({$0 != view })
                .forEach {
                    ($0 as? CheckListRowItemView)?.isChecked = false
            }
        case .multiple:
            break
        }
        
    }
    
   func updateCorners() {
 
        let views = self.view.stackView.arrangedSubviews.compactMap {
            _view -> CheckListRowItemView? in
            return _view as? CheckListRowItemView
        }
    
        guard selectionType == .multiple else {
            let selected =  views.filter { $0.isChecked == true }.first
            selected?.roundCorners(corners: [.allCorners])
            return
        }
    
        for (i, _view) in views.enumerated() {
            
            if
                views.indices.contains(i - 1),
                views[i - 1].isChecked,
                views.indices.contains(i + 1),
                views[i + 1].isChecked {
                
                // Remove rounded corners
                _view.roundCorners(radius: 0, corners: [.allCorners])
                
            } else if
                views.indices.contains(i - 1),
                views[i - 1].isChecked {
                
                // Round bottom only
                _view.roundCorners(corners: [.bottomLeft, .bottomRight])
                
            } else if
                views.indices.contains(i + 1),
                views[i + 1].isChecked {
                
                _view.roundCorners(corners: [.topLeft, .topRight])
                
            } else {
                _view.roundCorners(corners: [.allCorners])
            }
            
        }
        
    }
    
    init(tag: RowTag) {
        
        self.tag = tag
        let view: View = View.fromXib()
        self.view = view
        
    }
    
    convenience init(
        tag: RowTag,
        selectionType: SelectionType,
        label: String,
        options: [String],
        config: ((CheckListRow) -> Void)? = nil) {
        
        self.init(tag: tag)
        self.selectionType = selectionType
        self.view.label.text = label
        self.view.row = self
        self.addItems(labels: options)
        config?(self)
        
    }
    
}
