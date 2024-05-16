//
//  AccountController.swift
//  Cinema
//
//  Created by Kevin Han on 11/5/2024.
//

import Foundation

class AccountController: ObservableObject {
    static let shared = AccountController()

    @Published var accounts: [AccountModel] = []
    @Published var currentUser: AccountModel?

    // Private initializer for singleton instance
    private init() {}

    // Public initializer for testing purposes
    init(forTesting: Bool = false) {}

    func signUp(username: String, account: String, email: String, password: String) -> String? {
        if isUsernameOrEmailTaken(username: username, email: email) {
            return "Username or email already taken."
        }
        let newAccount = AccountModel(username: username, account: account, email: email, password: password)
        accounts.append(newAccount)
        return nil
    }

    func login(accountOrEmail: String, password: String) -> String? {
        let user = accounts.first { ($0.account == accountOrEmail || $0.email == accountOrEmail) && $0.password == password }
        if let user = user {
            currentUser = user
            return nil
        } else {
            return "Account or email not found, or password incorrect."
        }
    }

    func logout() {
        currentUser = nil
    }

    func updateEmail(newEmail: String) -> String? {
        guard let currentUser = currentUser else { return nil }
        if isEmailTaken(newEmail) {
            return "Email already taken."
        }
        if let index = accounts.firstIndex(where: { $0.id == currentUser.id }) {
            accounts[index].email = newEmail
            self.currentUser?.email = newEmail
            return nil
        }
        return "Failed to update email."
    }

    func updatePassword(newPassword: String) -> String? {
        guard let currentUser = currentUser else { return nil }
        if let index = accounts.firstIndex(where: { $0.id == currentUser.id }) {
            accounts[index].password = newPassword
            self.currentUser?.password = newPassword
            return nil
        }
        return "Failed to update password."
    }

    private func isUsernameOrEmailTaken(username: String, email: String) -> Bool {
        return accounts.contains { $0.username == username || $0.email == email }
    }

    private func isEmailTaken(_ email: String) -> Bool {
        return accounts.contains { $0.email == email }
    }
}
