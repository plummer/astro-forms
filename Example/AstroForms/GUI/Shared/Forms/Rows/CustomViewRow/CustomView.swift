//
//  CustomView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 26/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms

protocol CustomView where Self: UIView {
    var row: CustomViewRow<Self>? { get set }
}
