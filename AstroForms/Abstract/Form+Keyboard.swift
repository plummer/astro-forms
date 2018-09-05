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
    typealias KeyboardSizeChangeBlock = (CGFloat) -> Void
    
    /// A general handler for keyboard hiding / showing.
    ///
    /// - Parameters:
    ///   - notification: The keyboard notification
    ///   - animationBlock: The block to run as the keyboard changes size
    ///   - completionBlock: A completion block for after the animation
    private func keyboardSizeChangeHandler(
        notification: Notification,
        animationBlock: @escaping KeyboardSizeChangeBlock,
        completionBlock: (() -> Void)? = nil
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
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: curve,
            animations:
            { animationBlock(newBottomInset) }
        )   { _ in completionBlock?() }
    
    }
    
    /// Ensure the focus update occurs after the default scrollView position
    /// change.
    ///
    /// This is a hack and I can ideally remove it.
    func scrollToFocusedRow() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            self.focusRow()
        }
    }
    
    @objc func didBeginEditingTextField(_ notification: Notification) {
        scrollToFocusedRow()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        keyboardSizeChangeHandler(
            notification: notification,
            // `unowned` is safe
            animationBlock: {[unowned self] (newBottomInset) in
                
                self.scrollView.contentInset.bottom = newBottomInset
                self.scrollView.scrollIndicatorInsets.bottom = newBottomInset
                // Handle additional complex keyboard management here.
                // For example, showing multiple fields, and offset from the
                // field to the keyboard.
                self.scrollToFocusedRow()
                
        })
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        keyboardSizeChangeHandler(
            notification: notification,
            // `unowned` is safe
            animationBlock: {[unowned self] (newBottomInset) in
                
                self.scrollView.contentInset.bottom = newBottomInset
                self.scrollView.scrollIndicatorInsets.bottom = newBottomInset
                
        })
        
    }
    
}
