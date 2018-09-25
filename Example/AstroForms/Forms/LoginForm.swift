//
//  LoginForm.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 24/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import AstroForms

class LoginForm: Form {
    
    enum LoginFormTag: RowTag, Equatable {
        case
            hero,
            email,
            password,
            submit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupForm()
    }
    
    override func submit() {
        super.submit()
        
        guard isValid else { return }
        
        guard
            let emailRow: TextFieldRow = findRow(tag: LoginFormTag.email),
            let passwordRow: TextFieldRow = findRow(tag: LoginFormTag.password) else {
                return
        }
        
        let requestData = LoginFormData(
            email: emailRow.value,
            password: passwordRow.value
        )
        
    }
    
    func setupForm() {
        
        let heroRow = CustomViewRow<HeroView>(tag: LoginFormTag.hero)
        
        let emailRow = TextFieldRow(tag: LoginFormTag.email) {
            $0.view.label.text = "Email"
            $0.view.textField.placeholder = "example@astroforms.com"
            $0.view.textField.keyboardType = .emailAddress
            $0.view.textField.autocorrectionType = UITextAutocorrectionType.no
        }
        
        let passwordRow = TextFieldRow(tag: LoginFormTag.password) {
            $0.view.label.text = "Password"
            $0.view.textField.placeholder = "••••••"
            $0.view.textField.isSecureTextEntry = true
        }
        
        let submitRow = ButtonRow(tag: LoginFormTag.submit) {[unowned self] in
            $0.view.button.isEnabled = false
            $0.view.button.backgroundColor = .lightGray
            $0.buttonTapBlock = self.submit
            $0.title = "Login"
        }
        
        emailRow.focusRect = {
            CGRect(
                x: emailRow.baseView.frame.origin.x,
                y: emailRow.baseView.frame.origin.y,
                width: emailRow.baseView.frame.width,
                height:
                emailRow.baseView.frame.height
                    + passwordRow.baseView.frame.height
                    + submitRow.baseView.frame.height
            )
        }
        
        passwordRow.focusRect = {
            CGRect(
                x: passwordRow.baseView.frame.origin.x,
                y: passwordRow.baseView.frame.origin.y,
                width: passwordRow.baseView.frame.width,
                height:
                    passwordRow.baseView.frame.height
                    + submitRow.baseView.frame.height
            )
        }
        
        add(heroRow)
        add(emailRow)
        add(passwordRow)
        add(submitRow)
        
    }
    
    func updateEmailRowHintUI(row: TextFieldRow) {
        
        // Required
        guard validate(row: row, ValidationRule.required) else {
            row.showHelper(viewType: ErrorView.self, animated: true) {
                $0.label.text = "This field is required."
            }
            return
        }
        
        // Valid email in the format example@astroforms.com
        guard validate(row: row, ValidationRule.isEmail) else {
            row.showHelper(viewType: ErrorView.self, animated: true) {
                $0.label.text = "Please enter a valid email address."
            }
            return
        }
        
        row.hideHelper(animated: true)
        
    }
    
    func updatePasswordRowHint(row: TextFieldRow) {
        
        // Required
        guard validate(row: row, ValidationRule.required) else {
            row.showHelper(viewType: ErrorView.self, animated: true) {
                $0.label.text = "This field is required."
            }
            return
        }
        
        row.hideHelper(animated: true)
        
    }
    
    var isValid: Bool {
        
        guard
            let emailRow: TextFieldRow = findRow(tag: LoginFormTag.email),
            let passwordRow: TextFieldRow = findRow(tag: LoginFormTag.password)
            else {
                return false
        }
        
        guard
            validate(
                row: emailRow,
                ValidationRule.required,
                ValidationRule.isEmail
            ),
            validate(
                row: passwordRow,
                ValidationRule.required
            ) else {
                return false
        }
        
        return true
        
    }
    
    func updateButtonEnabledStateUI(row: ButtonRow) {
        let enabledButton = isValid
        row.view.button.isEnabled = enabledButton
        row.view.button.backgroundColor = enabledButton
            ? row.view.tintColor
            : .lightGray
    }
    
    override func rowUpdate(type: RowUpdate, row: AnyRow) {
    
        guard let tag = row.tag as? LoginFormTag else { return }
        
        switch type {
            case .live:
                
                // When any row is updated, update button row validity
                guard let buttonRow: ButtonRow = findRow(
                    tag: LoginFormTag.submit
                ) else {
                    return
                }
                
                updateButtonEnabledStateUI(row: buttonRow)
            
            case .regular:
                
                if tag == .email, let row = row as? TextFieldRow {
                    updateEmailRowHintUI(row: row)
                    return
                }
                
                if tag == .password, let row = row as? TextFieldRow {
                    updatePasswordRowHint(row: row)
                    return
                }
            
            default: break
        }
        
    }
    
}

struct LoginFormData: Codable {
    let email: String
    let password: String
}
