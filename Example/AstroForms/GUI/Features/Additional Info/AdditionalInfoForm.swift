//
//  AdditionalInfoForm.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class AdditionalInfoForm: Form, Themeable {
    
    enum AdditionalInfoRowTag: RowTag, Equatable {
        case aboutMe
    }
    
    var loginFormData: LoginFormData? {
        didSet {
            if let _loginFormData = loginFormData {
                setupForm(loginFormData: _loginFormData)
            }
        }
    }
    
    var theme: AstroTheme? = .light {
        didSet {
            updateTheme()
        }
    }
    
    func setupForm(loginFormData: LoginFormData) {
        
        let aboutRow = TextViewRow(tag: AdditionalInfoRowTag.aboutMe) {
            
            $0.view.label.text = "Your Bio"
            
        }
        
        add(aboutRow)
        
    }
    
    func updateAboutMeHintError(row: TextViewRow) {
        
        guard validate(row: row, ValidationRule.required) else {
            row.showHelper(viewType: ErrorView.self, animated: true) {
                $0.label.text = "This field is required"
            }
            return
        }
        
        guard validate(row: row, { $0.count <= 200 }) else {
            
            row.showHelper(viewType: ErrorView.self, animated: true) {
                $0.label.text =
                """
                \(row.value.count) / \(200), Too many characters
                """
            }
            return
        }
        
        row.showHelper(viewType: HintView.self, animated: true) {
            $0.label.text = "\(row.value.count) / \(200)"
        }
        
    }
    
    override func rowUpdate(type: RowUpdate, row: AnyRow) {
        
        guard let tag = row.tag as? AdditionalInfoRowTag else { return }
        
        switch type {
        case .live:
            
            if tag == .aboutMe, let row = row as? TextViewRow {
                updateAboutMeHintError(row: row)
            }
            
        default: break
            
        }
        
    }

}
