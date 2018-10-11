//
//  SlideAnimatedTransition.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 27/9/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation
import UIKit

/// A transition that simply slides view controllers, rather than the
/// default `UINavigationController` animation.
///
/// Useful for view controller transitions with backgrounds that remain static.
class SlideAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var direction: Direction = .right
    var duration: TimeInterval = 0.35
    
    enum Direction {
        case left, right
    }
   
    /// Initialise the transition with a left or right direction.
    ///
    /// - Parameters:
    ///   - direction: The `Direction` from which the new view arrives.
    ///   - duration: The duration of the transition
    convenience init(direction: Direction, duration: TimeInterval = 0.35) {
        self.init()
        self.direction = direction
        self.duration = duration
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from) else {
                return
        }
        
        let containerBounds = transitionContext.containerView.bounds
        
        func setFinalToViewState() {
            toView.frame = CGRect(
                x: containerBounds.origin.x,
                y: containerBounds.origin.y,
                width: toView.frame.width,
                height: toView.frame.height
            )
        }
        
        func setFinalFromViewState() {
            fromView.frame = CGRect(
                x: direction == .right
                    ? containerBounds.origin.x - fromView.frame.width
                    : containerBounds.maxX
                ,
                y: containerBounds.origin.y,
                width: fromView.frame.width,
                height: fromView.frame.height
            )
        }
        
        transitionContext.containerView.addSubview(toView)
        
        // Check for animated state, otherwise finish immediately
        guard transitionContext.isAnimated else {
            
            setFinalToViewState()
            setFinalFromViewState()
            
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
            
            return
            
        }
        
        toView.frame = CGRect(
            x: direction == .right
                ? containerBounds.maxX
                : containerBounds.origin.y - toView.frame.width,
            y: containerBounds.origin.y,
            width: toView.frame.width,
            height: toView.frame.height
        )
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                
                setFinalToViewState()
                setFinalFromViewState()
                
        }) { _ in
            transitionContext.completeTransition(
                !transitionContext.transitionWasCancelled
            )
        }
        
    }
    
}
