//
//  SignUpView.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

/// View for registering a new user account with fields for username, account, email, and password.
struct SignUpView: View {
    @EnvironmentObject var controller: AccountController // Access the shared AccountController instance.
    @Environment(\.presentationMode) var presentationMode // Access to dismiss the view.
    @State private var username = "" // State for username input.
    @State private var account = "" // State for account input.
    @State private var email = "" // State for email input.
    @State private var password = "" // State for password input.
    @State private var confirmPassword = "" // State for confirming password.
    @State private var showError = false // State to control error message visibility.
    @State private var errorMessage = "" // State to store and display the error message.

    var body: some View {
        VStack {
            // Input fields for user data.
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Display error message if there is an error.
            if showError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            // Button to initiate the sign-up process.
            Button("Sign Up") {
                if validateInputs() {
                    if let error = controller.signUp(username: username, account: account, email: email, password: password) {
                        errorMessage = error
                        showError = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
        }
        .navigationBarTitle("Sign Up")
    }

    /// Validates the inputs before attempting to sign up.
    /// Returns `true` if all validations pass, otherwise `false`.
    func validateInputs() -> Bool {
        if username.isEmpty || account.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "All fields are required"
            showError = true
            return false
        }

        if !Validator.isValidEmail(email) {
            errorMessage = "Invalid email format"
            showError = true
            return false
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showError = true
            return false
        }

        if !Validator.isValidPassword(password) {
            errorMessage = "Password must be 6 digits and contain at least one uppercase letter and one lowercase letter"
            showError = true
            return false
        }

        showError = false
        return true
    }
}

/// Preview provider to assist in designing and testing the SignUpView.
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AccountController(forTesting: true))
    }
}
