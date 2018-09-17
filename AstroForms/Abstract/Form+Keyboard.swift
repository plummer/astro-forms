//
//  Form+Keyboard.swift
//  Astro
//
//  Created by Andrew Plummer on 3/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import UIKit

// An extension to handle keyboard management
extension Form {
    
    /// A block that takes the new ideal scrollView offset.
    typealias KeyboardSizeChangeBlock = (
        CGFloat,
        Double,
        UIView.AnimationOptions
    ) -> Void
    
    /// A general handler for keyboard hiding / showing.
    ///
    /// - Parameters:
    ///   - notification: The keyboard notification
    ///   - animationBlock: The block to run as the keyboard changes size
    private func keyboardSizeChangeHandler(
        notification: Notification,
        animationBlock: @escaping KeyboardSizeChangeBlock
    ) {
        
        guard
            
            let keyboardInfo = notification.userInfo,
            
            // The frame of the keyboard when it is open
            let endFrame = keyboardInfo[
                UIResponder.keyboardFrameEndUserInfoKey
                ] as? NSValue,
            
            // The duration the keyboard takes to appear
            let duration = keyboardInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey
                ] as? Double,
            
            // The animation curve for the keyboard as it zooms up
            let curveValue = keyboardInfo[
                UIResponder.keyboardAnimationCurveUserInfoKey
                ] as? Int,
            let curve = UIView.AnimationCurve(
                rawValue: curveValue
                )?.toOptions() else {
                    return
        }
        
        /// The final keyboard frame in the context of the Form scrollView.
        let kbFrame = scrollView.convert(
            endFrame.cgRectValue,
            to: scrollView
        )
        
        let newBottomInset =
            frame.origin.y
                + frame.size.height
                - kbFrame.origin.y
        
        animationBlock(newBottomInset, duration, curve)
    
    }
    
    @objc func didBeginEditingTextField(_ notification: Notification) { }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        keyboardSizeChangeHandler(
            notification: notification,
            animationBlock: {
                [unowned self] (newBottomInset, duration, options) in

                self.scrollView.contentInset.bottom = newBottomInset
                self.scrollView.scrollIndicatorInsets.bottom = newBottomInset
                
                // Handle additional complex keyboard management here.
                // For example, showing multiple fields, and offset from the
                // field to the keyboard.
                DispatchQueue.main.async {[unowned self] in
                    // By default, animate rows with the same animation
                    // duration and options as the keyboard show / hide.
                    // This creates a smooth animation in this context,
                    // and seems fine for others.
                    self.focusRow(duration: duration, options: options)
                }

        })
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        keyboardSizeChangeHandler(
            notification: notification,
            animationBlock: {
                [unowned self] (newBottomInset, duration, options) in
                
                self.scrollView.contentInset.bottom = newBottomInset
                self.scrollView.scrollIndicatorInsets.bottom = newBottomInset
                
        })
        
    }
    
}
