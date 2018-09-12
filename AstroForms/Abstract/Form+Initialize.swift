//
//  Form+Initialize.swift
//  Astro
//
//  Created by Andrew Plummer on 21/6/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

extension Form {
    
    /// The general initialization function when forms are instantiated from
    /// code or storyboard.
    ///
    /// Sets up th overall form structure and keyboard handling.
    /// Only call this once per view, however call setupRows() many times.
    func initialize() {
        
        NotificationCenter.default.removeObserver(self)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBeginEditingTextField),
            name: UITextField.textDidBeginEditingNotification,
            // Also for UITextView
            object: nil
        )
        
        if !self.subviews.contains(scrollView) {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(scrollView)
            
            self.addConstraints([
                NSLayoutConstraint(
                    item: scrollView,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: scrollView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .leading,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: scrollView,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .trailing,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: scrollView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: 0
                )
            ])
        }
        
        // If the container view is not a subview, add it
        if !scrollView.subviews.contains(containerView) {
            containerView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(containerView)
            
            scrollView.addConstraints([
                NSLayoutConstraint(
                    item: containerView,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: scrollView,
                    attribute: .centerX,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: containerView,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: scrollView,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: containerView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: scrollView,
                    attribute: .leading,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: containerView,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: scrollView,
                    attribute: .trailing,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: containerView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: scrollView,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: 0
                )
            ])
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(stackView)
            
            containerView.addConstraints([
                NSLayoutConstraint(
                    item: stackView,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: containerView,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: stackView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: containerView,
                    attribute: .leading,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: stackView,
                    attribute: .trailing,
                    relatedBy: .equal,
                    toItem: containerView,
                    attribute: .trailing,
                    multiplier: 1.0,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: stackView,
                    attribute: .bottom,
                    relatedBy: .lessThanOrEqual,
                    toItem: containerView,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: 0
                )
            ])
            
        }
        
        stackView.axis = .vertical
        
    }
    
}
