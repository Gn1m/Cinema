//
//  LoginView.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

// View to handle user login
struct LoginView: View {
    @EnvironmentObject var controller: AccountController // Use EnvironmentObject to access the shared instance of AccountController
    @Environment(\.presentationMode) var presentationMode // Environment value to control the presentation mode
    @State private var account = "" // State variable to hold the account input
    @State private var password = "" // State variable to hold the password input
    @State private var showError = false // State variable to control the error message visibility

    var body: some View {
        VStack(spacing: 20) {
            // Text field for account input
            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()
                // Reset error message when account input changes
                .onChange(of: account) { _ in showError = false }

            // Secure field for password input
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()
                // Reset error message when password input changes
                .onChange(of: account) { _ in showError = false }

            // Show error message if login fails
            if showError {
                Text("Wrong password")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Login button
            Button("Login") {
                // Attempt to login with the provided credentials
                if let user = controller.login(account: account, password: password) {
                    controller.currentUser = user // Set the current user if login is successful
                    presentationMode.wrappedValue.dismiss() // Dismiss the login view
                } else {
                    showError = true // Show error message if login fails
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green) // Green background for the button
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
            .padding(.horizontal)
        }
        .navigationBarTitle("Login") // Set the navigation title
    }
}

// Preview provider to display the LoginView in Xcode previews
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AccountController()) // Provide a mock AccountController for the preview
    }
}
