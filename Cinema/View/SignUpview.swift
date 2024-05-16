//
//  SignUpView.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var controller: AccountController
    @Environment(\.presentationMode) var presentationMode
    @State private var username = ""
    @State private var account = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
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
            
            if showError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

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
            errorMessage = "Password must be 6 digis and contain at least one uppercase letter and one lowercase letter"
            showError = true
            return false
        }

        showError = false
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AccountController(forTesting: true))
    }
}
