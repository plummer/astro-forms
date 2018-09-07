//
//  TextViewView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 7/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class TextViewRowView: UIView, UITextViewDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    //weak var row: TextViewRow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
    
    }
    
}
