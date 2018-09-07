//
//  DefaultKeyboardToolbarDelegate.swift
//  AstroForms
//
//  Created by Andrew Plummer on 7/9/18.
//

import Foundation

@objc public protocol DefaultKeyboardToolbarDelegate {
    @objc func keyboardToolbarDoneTapped()
    @objc func keyboardToolbarNextTapped()
    @objc func keyboardToolbarPreviousTapped()
}
