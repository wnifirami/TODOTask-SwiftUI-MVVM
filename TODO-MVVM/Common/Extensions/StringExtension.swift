//
//  StringExtension.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // check if full name is alphabetic
    func isValidName() -> Bool {
        let nameRegEx = "([\\u00C0-\\u017Fa-zA-Z’]+[- _‘]?)+"
        
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self) 
    }
    
    
    // check if age is numeric
    func isValidAge() -> Bool {
        guard let _ = Int(self) else {
            return false
        }
        return true
    }
    // checking password format
    func isValidPassword() -> Bool {
        // Contains at least one ucase
        let uppperCaseRegEx  = ".*[A-Za-z0-9]+.*"
        let uppperCaseTest = NSPredicate(format: "SELF MATCHES %@", uppperCaseRegEx)
        let uppperCaseTestResult = uppperCaseTest.evaluate(with: self)
        let specialCaracterRegEx = ".*[@$!%*?&£+¥€#]+.*"
        let specialCaracterTest = NSPredicate(format: "SELF MATCHES %@", specialCaracterRegEx)
        let specialCaracterResult = specialCaracterTest.evaluate(with: self)
        let countTestResult = self.count > 7
        return uppperCaseTestResult && specialCaracterResult && countTestResult
    }
}
