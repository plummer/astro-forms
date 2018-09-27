//
//  ButtonRowView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 9/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

class ButtonRowView: UIView, Themeable {
    
    var theme: AstroTheme?
    
    weak var row: ButtonRow?
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        row?.buttonTapped()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchDragOutside)
    }
    
    @objc func buttonTouchDown() {
        
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.button.transform = CGAffineTransform.init(
                scaleX: 1.03, y: 1.03
            )
        }
        
    }
    
    @objc func buttonTouchUp() {
        
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.button.transform = CGAffineTransform.init(
                scaleX: 1.00, y: 1.00
            )
        }
        
    }
    
    func updateTheme() {
        
        button.setBackgroundImage(
            UIImage.from(color: color(.buttonBackground)),
            for: .normal
        )
        
        button.setBackgroundImage(
            UIImage.from(color: color(.buttonHighlightedBackground)),
            for: .highlighted
        )
        
        button.setBackgroundImage(
            UIImage.from(color: color(.buttonDisabledBackground)),
            for: .disabled
        )
        
        button.setTitleColor(color(.buttonText), for: .normal)
        
        button.setTitleColor(color(.buttonDisabledText), for: .disabled)
        
        backgroundColor = color(.primaryBackground)

    }
    
}
