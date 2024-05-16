//
//  AccountModel.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import Foundation

/// Represents a user account in the system, containing essential user information.
struct AccountModel: Identifiable {
    var id = UUID()  // Unique identifier for the account, generated automatically.
    var username: String  // The user's chosen username.
    var account: String  // The user's account name, possibly used for login.
    var email: String  // The user's email address, used for communication and potentially login.
    var password: String  // The user's password for accessing their account.

    /// Initializes a new AccountModel with all required user details.
    /// - Parameters:
    ///   - username: The user's chosen username.
    ///   - account: The user's account name.
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///
    /// This initialization is straightforward, ensuring each new account is uniquely identified
    /// and equipped with necessary information for account management.
    init(username: String, account: String, email: String, password: String) {
        self.username = username
        self.account = account
        self.email = email
        self.password = password
    }
}

/// The purpose of this structure is to provide a simple yet comprehensive representation of a user account,
/// facilitating operations like logins, account updates, and user management across the system.
