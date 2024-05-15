//
//  SignUpview.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

// View to handle user sign-up
struct SignUpView: View {
    @EnvironmentObject var controller: AccountController // Use EnvironmentObject to access the shared instance of AccountController
    @Environment(\.presentationMode) var presentationMode // Environment value to control the presentation mode
    @State private var username = "" // State variable to hold the username input
    @State private var account = "" // State variable to hold the account input
    @State private var password = "" // State variable to hold the password input
    @State private var confirmPassword = "" // State variable to hold the confirm password input

    var body: some View {
        VStack {
            // Text field for username input
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()

            // Text field for account input
            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()

            // Secure field for password input
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()

            // Secure field for confirm password input
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Rounded border style for the text field
                .padding()

            // Display error message if passwords do not match
            if password != confirmPassword {
                Text("Your password does not match!")
                    .font(.caption)
                    .foregroundColor(.red)
            }

            // Sign up button
            Button("Sign Up") {
                // Check if passwords match before signing up
                if password == confirmPassword {
                    controller.signUp(username: username, account: account, password: password) // Sign up the user
                    presentationMode.wrappedValue.dismiss() // Dismiss the sign-up view
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green) // Green background for the button
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
            .padding(.horizontal)
        }
        .navigationBarTitle("Sign Up") // Set the navigation title
    }
}

// Preview provider to display the SignUpView in Xcode previews
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AccountController()) // Provide a mock AccountController for the preview
    }
}
