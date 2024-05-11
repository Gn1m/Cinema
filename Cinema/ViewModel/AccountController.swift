//
//  AccountController.swift
//  Cinema
//
//  Created by Kevin Han on 11/5/2024.
//

import Foundation

class AccountController: ObservableObject {
    @Published var accounts: [AccountModel] = []
    @Published var currentUser: AccountModel?

    func signUp(username: String, account: String, password: String) {
        let newAccount = AccountModel(username: username, account: account, password: password)
        accounts.append(newAccount)
        // Do not set currentUser to keep the greeting as "Hello Guest"
    }

    func login(account: String, password: String) -> AccountModel? {
            return accounts.first { $0.account == account && $0.password == password }
        }
}
