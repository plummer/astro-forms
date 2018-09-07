//
//  DefaultKeyboardTraits.swift
//  AstroForms
//
//  Created by Andrew Plummer on 7/9/18.
//

import Foundation
import UIKit


// TODO: This is a really awkward way of exposing shared toolbar functionality
// between view classes. Refactor to a more appropriate structure to support
// many keyboard types.
public extension DefaultKeyboardToolbarDelegate {
    
    func defaultToolbar<T: FocusableRow>(row: T?) -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarDoneTapped)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarNextTapped)
        )
        
        nextButton.isEnabled = row?.nextFocusableRow != nil
        
        let previousButton = UIBarButtonItem(
            title: "Previous",
            style: .plain,
            target: self,
            action: #selector(keyboardToolbarPreviousTapped)
        )
        
        previousButton.isEnabled = row?.previousFocusableRow != nil
        
        toolbar.setItems([
            previousButton,
            nextButton,
            flexibleSpace,
            doneButton
            ], animated: false
        )
        
        return toolbar
        
    }
    
}
