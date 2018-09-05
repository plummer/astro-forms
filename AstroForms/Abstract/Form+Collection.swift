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
extension Form: RangeReplaceableCollection {
    
    /// A type that represents a collection of rows in the form.
    public typealias RowCollectionType = [AnyRow]
    
    public typealias Index = RowCollectionType.Index
    
    public typealias Element = RowCollectionType.Element
    
    public var startIndex: Int { return 0 }
    
    public var endIndex: Int { return rows.count }
    
    public func index(
        after i: Form.RowCollectionType.Index
        ) -> Form.RowCollectionType.Index {
        
        return rows.index(after: i)
        
    }
    
    public subscript(position: Form.RowCollectionType.Index) -> Form.RowCollectionType.Element {
        
        get { return rows[position] }
        set(newValue) { rows[position] = newValue }
        
    }
    
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
    
    public func append(_ newElement: Form.RowCollectionType.Element) {
        rows.append(newElement)
        stackView.addArrangedSubview(stackWrapped(newElement.baseView))
        
    }
    
    public func append<S>(contentsOf newElements: S)
        where S: Sequence,
        Form.Element == S.Element {
            
        rows.append(contentsOf: newElements)
        newElements.forEach { stackView.addArrangedSubview(stackWrapped($0.baseView)) }
        
    }
    
    public func replaceSubrange<C, R>(_ subrange: R, with newElements: C)
        where C: Collection,
        R: RangeExpression,
        Form.Element == C.Element,
        Form.Index == R.Bound {
            
        let range = subrange.relative(to: rows)
            
        rows.replaceSubrange(subrange, with: newElements)
            
        for i in stride(from: range.lowerBound, to: range.upperBound, by: 1) {
            
            stackView.subviews[i].removeFromSuperview()
            stackView.insertArrangedSubview(rows[i].baseView, at: i)
            
        }
            
    }
    
}
