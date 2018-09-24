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
        
        let textField = TextFieldRow(
            tag: KitchenSinkTag.email,
            title: "Email",
            value: nil,
            placeholder: "email@astroforms.com",
            keyboardType: .emailAddress,
            isSecureTextEntry: false,
            clearButtonMode: .whileEditing
        )
        
        textField.onRowUpdate = {[unowned self] in
            
            guard $0 == .regular else {
                return
            }
            
            if self.validate(
                row: textField,
                { $0.count > 5 }
                ) {
                
                textField.view.label.textColor = .red

                textField.showHelper(
                    viewType: ErrorView.self,
                    animated: true
                ) { view in
                    view.label.text =
                    """
                    \(textField.value.count) characters entered, the maximum is 5
                    """
                }
                
            } else {
                
                textField.view.label.textColor = .black
                
                textField.hideHelper(animated: true)
                
            }
            
        }
        
        let passwordField = TextFieldRow(
            tag: KitchenSinkTag.password,
            title: "Password",
            value: nil,
            placeholder: "******",
            keyboardType: .default,
            isSecureTextEntry: true,
            clearButtonMode: .always
        )
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if hasFirstRun == false {
            
            
            
            hasFirstRun = true
            setNeedsLayout()
            layoutIfNeeded()
            
        }
        
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
