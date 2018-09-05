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
    
    enum KitchenSinkTag: RowTag {
        case helloWorld
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        do {
            
            let textField = try PlainTextFieldRow(
                tag: KitchenSinkTag.helloWorld,
                title: "Hello world",
                value: nil,
                placeholder: "Respond?",
                keyboardType: .emailAddress,
                isSecureTextEntry: false,
                clearButtonMode: .whileEditing
            )
            
            self.append(textField)
            
        } catch let error {
            debugPrint("Error:", error)
        }
        
    }
    
}
