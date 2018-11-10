//
//  PasswordValidator.swift
//  alpha
//
//  Created by Ehsan on 8/28/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

public class PasswordValidator{
    static func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one specific char
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[@,#,$,%,+,=,_,*,?]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    static func hasPasswordMinimumLength(testStr:String?) -> Bool {
        return (testStr?.count)! > 7
    }
    
    static func hasPasswordCustomCharacters(testStr:String?) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[@,#,$,%,+,=,_,*,?]).{1,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    static func hasPasswordCapitalLetter(testStr:String?) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z]).{1,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    static func hasPasswordDigit(testStr:String?) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[0-9]).{1,}")
        return passwordTest.evaluate(with: testStr)
        
    }
}
