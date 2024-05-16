//
//  Validator.swift
//  Cinema
//
//  Created by Ming Z on 16/5/2024.
//

import Foundation

/// Validator class to validate email and password formats
class Validator {
    /// Validate email format
    /// - Parameter email: Email string to validate
    /// - Returns: Boolean indicating whether the email is valid
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    /// Validate password format
    /// - Parameter password: Password string to validate
    /// - Returns: Boolean indicating whether the password is valid
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z]).{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
}
