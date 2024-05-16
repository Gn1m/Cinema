//
//  LoginView.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

/// A view for handling user login with input fields for account/email and password.
struct LoginView: View {
    @EnvironmentObject var controller: AccountController // Access the shared AccountController instance.
    @Environment(\.presentationMode) var presentationMode // Access the presentation mode to dismiss the view.
    @State private var accountOrEmail = "" // State to hold the input for account or email.
    @State private var password = "" // State to hold the input for password.
    @State private var showError = false // State to control error message visibility.
    @State private var errorMessage = "" // State to store and display the error message.

    var body: some View {
        VStack(spacing: 20) {
            // Input field for account or email.
            TextField("Account or Email", text: $accountOrEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: accountOrEmail) { _ in showError = false } // Reset error state when text changes.

            // Input field for password.
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: password) { _ in showError = false } // Reset error state when text changes.

            // Display error message if there is an error.
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Button to initiate login process.
            Button("Login") {
                if let error = controller.login(accountOrEmail: accountOrEmail, password: password) {
                    errorMessage = error
                    showError = true
                } else {
                    // Perform additional actions post-login and dismiss the view.
                    CinemaModelManager.shared.login(account: controller.currentUser!)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
        }
        .navigationBarTitle("Login") // Set the navigation bar title for the view.
    }
}

/// Preview provider to assist in designing and testing the LoginView.
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AccountController(forTesting: true))
    }
}
