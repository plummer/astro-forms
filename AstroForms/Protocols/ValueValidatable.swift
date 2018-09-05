//
//  ValueValidatable.swift
//  Astro
//
//  Created by Andrew Plummer on 3/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation

protocol ValueValidatable {
    
    var hasChanged: Bool { get set }
    
    var hasStartedEditing: Bool { get set }
    
    var hasEndedEditing: Bool { get set }
    
}
