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
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if hasFirstRun == false {
            
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
                
                try textField.showHelper(viewType: HintView.self, animated: false) {
                    $0.title = "Start here by entering a valid email..."
                }
                
                self.add(passwordField)
                
                let buttonRowView = try ButtonRow(
                    tag: KitchenSinkTag.submit,
                    title: "Submit",
                    tapBlock: self.submit)
                
                self.add(buttonRowView)
                
                
            } catch let error {
                debugPrint("Error:", error)
            }
            
            hasFirstRun = true
            setNeedsLayout()
            layoutIfNeeded()
            
        }
        
    }
    
    func submit() { }
    
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
            
            guard helloWorldRow.tag as! KitchenSinkTag == KitchenSinkTag.email else { return }
            
            if validate(
                row: helloWorldRow,
                { $0.count > 5 }
                ) {
                
                do {
                    try helloWorldRow.showHelper(
                        viewType: ErrorView.self,
                        animated: true
                    ) { view in
                        
                        view.label.text = "\(helloWorldRow.value.count) characters entered, the maximum is 5"
                        
                    }
                } catch {
                    
                }
                
            } else {
                
                helloWorldRow.hideHelper(animated: true)
                
            }
            
        }
        
    }
    
}
