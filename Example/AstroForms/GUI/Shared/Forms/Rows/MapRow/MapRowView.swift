//
//  MapRowView.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 30/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapRowView: UIView, Themeable {
    
    var theme: AstroTheme?
    
    weak var row: MapRow?
    @IBOutlet weak var marker: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    
    func updateTheme() {
        self.backgroundColor = color(.primaryBackground)
        marker.tintColor = color(.primaryTint)
    }
    
}
