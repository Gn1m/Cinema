//
//  AccountModel.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import Foundation


struct AccountModel: Identifiable {
    var id = UUID()  // Unique identifier for the account, generated automatically.
    var username: String  // The user's chosen username.
    var account: String  // The user's account name, possibly used for login.
    var email: String  // The user's email address, used for communication and potentially login.
    var password: String  // The user's password for accessing their account.

    init(username: String, account: String, email: String, password: String) {
        self.username = username
        self.account = account
        self.email = email
        self.password = password
    }
}
