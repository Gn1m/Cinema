//
//  AccountController.swift
//  Cinema
//
//  Created by Kevin Han on 11/5/2024.
//

import Foundation

// Manages user accounts, handling operations like sign-up, login, and user data updates.
class AccountController: ObservableObject {
    static let shared = AccountController()

    @Published var accounts: [AccountModel] = []
    @Published var currentUser: AccountModel?

    // Private initializer for singleton pattern
    private init() {}

    // Public initializer for testing scenarios
    init(forTesting: Bool = false) {}

    // Signs up a new user with provided credentials.
    // - Returns: An error message if the sign-up fails, nil if successful.
    func signUp(username: String, account: String, email: String, password: String) -> String? {
        if isUsernameOrEmailTaken(username: username, email: email) {
            return "Username or email already taken."
        }
        let newAccount = AccountModel(username: username, account: account, email: email, password: password)
        accounts.append(newAccount)
        return nil
    }

    // Attempts to log in a user with the given credentials.
    // - Returns: An error message if login fails, nil if successful.
    func login(accountOrEmail: String, password: String) -> String? {
        if let user = accounts.first(where: { ($0.account == accountOrEmail || $0.email == accountOrEmail) && $0.password == password }) {
            currentUser = user
            return nil
        }
        return "Account or email not found, or password incorrect."
    }

    // Logs out the current user.
    func logout() {
        currentUser = nil
    }

    // Updates the email of the current user.
    // - Returns: An error message if the update fails, nil if successful.
    func updateEmail(newEmail: String) -> String? {
        guard let currentUser = currentUser, !isEmailTaken(newEmail) else {
            return "Email already taken."
        }
        if let index = accounts.firstIndex(where: { $0.id == currentUser.id }) {
            accounts[index].email = newEmail
            self.currentUser?.email = newEmail
            return nil
        }
        return "Failed to update email."
    }
    
    // Updates the password of the current user.
    // - Returns: An error message if the update fails, nil if successful.
    func updatePassword(newPassword: String) -> String? {
        guard let currentUser = currentUser else { return nil }
        if let index = accounts.firstIndex(where: { $0.id == currentUser.id }) {
            accounts[index].password = newPassword
            self.currentUser?.password = newPassword
            return nil
        }
        return "Failed to update password."
    }

    // Checks if the username or email is already taken.
    private func isUsernameOrEmailTaken(username: String, email: String) -> Bool {
        return accounts.contains { $0.username == username || $0.email == email }
    }

    // Checks if an email is already registered.
    private func isEmailTaken(_ email: String) -> Bool {
        return accounts.contains { $0.email == email }
    }
}
