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
    
    enum LoginTag: RowTag, Equatable {
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
        
        let textField = TextFieldRow(tag: LoginTag.email) { row in
            row.view.textField.placeholder = "Enter your email..."
        }
        
        let passwordField = TextFieldRow(tag: LoginTag.password) {
            $0.view.label.text = "Password"
            $0.view.textField.isSecureTextEntry = true
        }
        
        let rememberMe = SwitchRow(tag: LoginTag.termsConditions) {
            $0.value = true
            $0.view.label.text = "Remember Me"
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
        
        self.add(rememberMe)
        
        let buttonRowView = ButtonRow(
            tag: LoginTag.submit
        )
        
        self.add(buttonRowView)
        
    }
    
    func validateEmailRow(row: TextFieldRow) {
        
        guard self.validate(row: row, ValidationRule.required) else {
            
            row.showHelper(viewType: HintView.self, animated: true) {
                $0.label.text = "Enter an email to get started..."
            }
            
            return
        }
        
        if self.validate(row: row, ValidationRule.isEmail) {

            row.showHelper(viewType: HintView.self, animated: true) {
                $0.label.text = "Your new username will be \(row.value)"
            }
            
        } else {
            row.hideHelper(animated: true)
        }
        
    }
    
    override func submit() {
        super.submit()
    }
    
    override func rowUpdate(type: RowUpdate, row: AnyRow) {
        
        guard let tag = row.tag as? LoginTag else { return }
        guard type == .regular else { return }
        
        if tag == LoginTag.email, let row = row as? TextFieldRow {
            validateEmailRow(row: row)
        }
        
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
            
            guard helloWorldRow.tag as! LoginTag == LoginTag.email else { return }

        }
        
    }
    
}
