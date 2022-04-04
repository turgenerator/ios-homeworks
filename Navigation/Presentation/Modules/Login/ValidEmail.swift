//
//  ValidUserInfo.swift
//  Navigation
//
//  Created by Nikita Turgenev on 04.04.2022.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
        
    }
}
