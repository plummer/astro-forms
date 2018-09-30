//
//  CheckListRowItemView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 30/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol CheckListRowItemViewDelegate: class {
    
    func willSelect(_ view: CheckListRowItemView)
    
    func updateCorners()
    
}

class CheckListRowItemView: UIView, Themeable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var theme: AstroTheme? = nil
    
    weak var delegate: CheckListRowItemViewDelegate?
    
    var isChecked: Bool {
        get {
            return self.state == .checked
        }
        set {
            state = newValue == true ? .checked : .unchecked
        }
    }
    
    enum State {
        case
            checked,
            unchecked
    }
    
    enum ListPosition {
        case
            start,
            middle,
            end,
            single
    }
    
    var state: State = .unchecked {
        didSet {
            setSelectedState(
                state: state,
                listPosition: listPosition
            )
        }
    }
    
    var listPosition: ListPosition = .middle {
        didSet {
            setSelectedState(
                state: state,
                listPosition: listPosition
            )
        }
    }
    
    func setSelectedState(
        state: State,
        listPosition: ListPosition
    ) {
        
        self.delegate?.updateCorners()
        
        switch state {
            case .checked:
                
                updateTheme()

                UIView.animate(
                    withDuration: 0.6,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.3, options: [], animations: {
                        [unowned self] in
                        
                        self.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                        
                }, completion: nil)
            
            case .unchecked:
                
                self.layer.zPosition = 0
                
                UIView.animate(
                    withDuration: 0.15,
                    delay: 0,
                    options: [.curveEaseOut],
                    animations: {[unowned self] in
                        self.transform = CGAffineTransform(
                            scaleX: 1.00,
                            y: 1.00
                        )
                        
                        self.updateTheme()
                        
                    },
                    completion: {[unowned self] _ in
                        
                        switch listPosition {
                        case .start:
                            self.roundCorners(corners: [.topLeft, .topRight])
                        case .middle:
                            self.roundCorners(radius: 0, corners: [.allCorners])
                        case .end:
                            self.roundCorners(corners: [.bottomLeft, .bottomRight])
                        case .single:
                            self.roundCorners(corners: [.allCorners])
                            
                        }
                        
                }
            )
            
        }
        
    }
    
    func roundCorners(radius: CGFloat = 12, corners: UIRectCorner) {
        
        // Layout required to round corners because otherwise the bounds
        // may not have correct size
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewTapped(_:))
            )
        )
        
    }
    
    func select() {
        
        if !self.isChecked { delegate?.willSelect(self) }
        self.isChecked.toggle()
        
    }
    
    @objc func viewTapped(_ sender: UIView) {
        select()
        self.window?
            .rootViewController?
            .view.firstResponder?
            .resignFirstResponder()
    }
    
    func updateTheme() {
        
        switch state {
            
        case .checked:
            
            imageView.image = #imageLiteral(resourceName: "Check-filled")
            imageView.tintColor = .white
            label.textColor = color(.inputLabelColor)
            self.backgroundColor = color(.primaryTint)
            self.layer.zPosition = 1
            
        case .unchecked:
            
            self.imageView.image = #imageLiteral(resourceName: "Check-unfilled")
            self.imageView.tintColor = self.color(.inputDisabledBackground)
            self.label.textColor = self.color(.inputTextColor)
            self.backgroundColor = self.color(.inputBackground)
            
        }
        
    }
    
}
