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
        
        do {
            
            let textField = try TextFieldRow(
                tag: KitchenSinkTag.email,
                title: "Email",
                value: nil,
                placeholder: "email@astroforms.com",
                keyboardType: .emailAddress,
                isSecureTextEntry: false,
                clearButtonMode: .whileEditing
            )
            
            let passwordField = try TextFieldRow(
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
            self.add(passwordField)
            
            let buttonRowView = try ButtonRow(
                tag: KitchenSinkTag.submit,
                title: "Submit") {
                    
                    debugPrint("button tapped")
                    
            }
            
            //let result = ValidationTest.email(32)
            
            self.add(buttonRowView)
            
            
        } catch let error {
            debugPrint("Error:", error)
        }
        
    }
    
    override func rowUpdate(type: RowUpdate, row: AnyRow) {
        
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
            
            let isValid = validate(
                row: helloWorldRow,
                { $0.count > 2 },
                { $0.count < 5 },
                { $0.contains("@") }
            )
            
            print("example email validity", isValid)
            
        }
        
    }
    
}
