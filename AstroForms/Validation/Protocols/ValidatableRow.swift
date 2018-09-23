//
//  ValidatableRow.swift
//  AstroForms
//
//  Created by Andrew Plummer on 18/9/18.
//

import Foundation

public protocol ValidatableForm {
    
    typealias ValidationRuleMsgBlock<R: ValueRow> = ((R.Value) -> Bool, String)
    
    typealias ValidationRuleBlock<R: ValueRow> = (R.Value) -> Bool
    
    func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> (Bool, String?)
    
    func validateList<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> [(Bool, String?)]
    
    func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleBlock<R>...) -> Bool
    
}

public extension ValidatableForm {
    
    @discardableResult
    public func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> (Bool, String?) {
        
        for rule in rules {
            
            if rule.0(row.value) == false {
                return (false, rule.1)
            }
            
        }
        
        return (true, nil)
        
    }
    
    @discardableResult
    public func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleBlock<R>...) -> Bool {
        
        for rule in rules {
            
            if rule(row.value) == false {
                return false
            }
            
        }
        
        return true
        
    }
    
    @discardableResult
    func validateList<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> [(Bool, String?)] {
        
        let rulesResults: [(Bool, String?)] = rules.map({
            return ($0.0(row.value), $0.1)
        })
        
        return rulesResults
        
    }
    
}


