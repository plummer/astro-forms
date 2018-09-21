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
    
    func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> [(Bool, String?)]
    
    func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleBlock<R>...) -> Bool
    
}

public extension ValidatableForm {
    
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
    
    func validate<R: ValueRow>(
        row: R,
        _ rules: ValidationRuleMsgBlock<R>...) -> [(Bool, String?)] {
        
        var failedRules: [(Bool, String?)] = []
        
        for rule in rules {
            if rule.0(row.value) == false {
                failedRules.append((false, rule.1))
            }
        }
        
        return failedRules
        
    }
    
}


