//
//  Form+Collection.swift
//  Astro
//
//  Created by Andrew Plummer on 23/7/18.
//  Copyright © 2018 Andrew Plummer. All rights reserved.
//

import Foundation
import UIKit

/// A form can be represented as a collection of any row types.
extension Form {
    
    private func stackWrapped(_ view: UIView) -> UIStackView {
        
        let wrapStackView = UIStackView()
        wrapStackView.axis = .vertical
        wrapStackView.addArrangedSubview(view)
        
//        let secondStack = UIStackView()
//
//        let errorView: ErrorView = try! ErrorView.fromXib()
//
//        secondStack.addArrangedSubview(errorView)
//        wrapStackView.addArrangedSubview(secondStack)
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//            errorView.show(message: "hello", animated: true)
//        }
        
        return wrapStackView
        
    }
    
    public func add(_ row: AnyRow) {
        
        rows.append(row)
        stackView.addArrangedSubview(stackWrapped(row.baseView))
        
    }
    
    public func insert(_ row: AnyRow, at index: Int) {
        
        rows.insert(row, at: index)
        stackView.insertArrangedSubview(stackWrapped(row.baseView), at: index)
        
    }
    
    public func remove(at index: Int) {
    
        rows.remove(at: index)
        stackView.subviews[index].removeFromSuperview()
    
    }

    
}
