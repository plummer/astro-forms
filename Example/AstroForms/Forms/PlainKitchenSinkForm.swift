//
//  PlainKitchenSinkForm.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 5/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class PlainKitchenSinkForm: Form {
    
    var hasFirstRun: Bool = false
    
    enum KitchenSinkTag: RowTag, Equatable {
        case
        termsConditions,
        about,
        custom(String),
        email,
        password,
        submit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let textField = TextFieldRow(tag: KitchenSinkTag.email) { row in
            row.view.textField.placeholder = "Enter your email..."
            
            row.onRowUpdate = {[unowned self] update in
                
                guard update == .regular else {
                    return
                }
                
                if self.validate(
                    row: row,
                    { $0.count > 5 }
                    ) {
                    
                    row.view.label.textColor = .red
                    
                    row.showHelper(
                        viewType: ErrorView.self,
                        animated: true
                    ) { view in
                        view.label.text =
                        """
                        \(row.value.count) characters entered, the maximum is 5
                        """
                    }
                    
                } else {
                    
                    row.view.label.textColor = .black
                    row.hideHelper(animated: true)
                    
                }
            }
            
        }
        
        let passwordField = TextFieldRow(tag: KitchenSinkTag.password) {
            $0.view.label.text = "Password"
        }
        
        textField.focusRect = {
            CGRect(
                x: textField.baseView.frame.origin.x,
                y: textField.baseView.frame.origin.y,
                width: textField.baseView.frame.width,
                height: textField.baseView.frame.height + passwordField.baseView.frame.height
            )
        }
        
        self.add(textField)
        
        textField.showHelper(viewType: HintView.self, animated: false) {
            $0.title = "Start here by entering a valid email..."
        }
        
        self.add(passwordField)
        
        let buttonRowView = ButtonRow(
            tag: KitchenSinkTag.submit,
            title: "Submit",
            tapBlock: self.submit)
        
        self.add(buttonRowView)
        
    }
    
    func submit() { }
    
    override func rowUpdate(type: RowUpdate, row: AnyRow) {
        super.rowUpdate(type: type, row: row)
        
        switch type {
            
        case .live:
            break
            
        case .onResignActive:
            break
            
        case .onResignActiveAfterChange:
            break
            
        case .regular:
            
            guard let helloWorldRow = row as? TextFieldRow else {
                return
            }
            
            guard helloWorldRow.tag as! KitchenSinkTag == KitchenSinkTag.email else { return }

        }
        
    }
    
}
