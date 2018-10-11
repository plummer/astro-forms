//
//  MapRow.swift
//  AstroForms_Example
//
//  Created by Andrew Plummer on 30/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import AstroForms
import CoreLocation

class MapRow: Row, ValueRow {
    
    typealias View = MapRowView
    
    typealias Value = CLLocationCoordinate2D
    
    var view: MapRowView
    
    var value: CLLocationCoordinate2D {
        
        set {
            self.view.map.centerCoordinate = newValue
            valueDidEndEditing()
        }
        
        get {
            return self.view.map.centerCoordinate
        }
        
    }
    
    var tag: RowTag
    
    var valueHasChanged: Bool = false
    
    var valueHasEndedEditing: Bool = false
    
    var valueHasStartedEditing: Bool = false
    
    init(tag: RowTag, location: CLLocationCoordinate2D, config: ((MapRow) -> Void)? = nil) {
        
        let view: MapRowView = View.fromXib()
        self.tag = tag
        self.view = view
        self.value = location
        view.row = self
        config?(self)
        
    }
    
}
