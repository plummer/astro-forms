//
//  SlideNavigationController.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 27/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SlideNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return operation == .push
            ? SlideAnimatedTransition(direction: .right)
            : SlideAnimatedTransition(direction: .left)
        
    }
    
}
