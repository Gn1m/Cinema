//
//  AccountView.swift
//  Cinema
//
//  Created by Ming Z on 8/5/2024.
//

import SwiftUI

/// A view for managing user accounts, providing options to update email and password, or to log out.
struct AccountView: View {
    @EnvironmentObject var controller: AccountController // Access the shared AccountController instance.
    @State private var showingUpdateEmail = false // State to show or hide the email update interface.
    @State private var showingUpdatePassword = false // State to show or hide the password update interface.
    @State private var newEmail = "" // State to capture the new email input.
    @State private var newPassword = "" // State to capture the new password input.
    @State private var confirmPassword = "" // State to capture the password confirmation input.
    @State private var errorMessage = "" // State to display error messages.

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Display a greeting message that adjusts based on user login status.
                Text(controller.currentUser == nil ? "Hello Guest" : "Hello \(controller.currentUser!.username)")
                    .font(.largeTitle)
                    .padding()

                Spacer()

                // Display different controls based on whether the user is logged in.
                if let currentUser = controller.currentUser {
                    // Details and actions for logged-in users.
                    VStack(spacing: 10) {
                        Text("Email: \(currentUser.email)")

                        // Button to update email.
                        Button("Update Email") {
                            showingUpdateEmail.toggle()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                        // Button to update password.
                        Button("Update Password") {
                            showingUpdatePassword.toggle()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                        // Button to log out the user.
                        Button("Log Out") {
                            controller.logout()
                            CinemaModelManager.shared.logout() // Log out from CinemaModelManager as well.
                            OrderViewModel.shared.fetchOrders() // Refresh orders after logging out.
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    }
                } else {
                    // Options for guests to sign up or log in.
                    NavigationLink(destination: SignUpView().environmentObject(controller)) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: LoginView().environmentObject(controller)) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .padding()
            .sheet(isPresented: $showingUpdateEmail) {
                // Email update interface.
                updateEmailView()
            }
            .sheet(isPresented: $showingUpdatePassword) {
                // Password update interface.
                updatePasswordView()
            }
        }
    }

    /// View for updating the user's email address.
    private func updateEmailView() -> some View {
        VStack {
            TextField("New Email", text: $newEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Button to submit the new email.
            Button("Update") {
                if Validator.isValidEmail(newEmail) {
                    if let error = controller.updateEmail(newEmail: newEmail) {
                        errorMessage = error
                    } else {
                        showingUpdateEmail = false
                    }
                } else {
                    errorMessage = "Invalid email format"
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
        }
        .padding()
    }

    /// View for updating the user's password.
    private func updatePasswordView() -> some View {
        VStack {
            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Button to submit the new password.
            Button("Update") {
                if newPassword == confirmPassword {
                    if Validator.isValidPassword(newPassword) {
                        if let error = controller.updatePassword(newPassword: newPassword) {
                            errorMessage = error
                        } else {
                            showingUpdatePassword = false
                        }
                    } else {
                        errorMessage = "Password must be 6 digits and contain at least one uppercase letter and one lowercase letter"
                    }
                } else {
                    errorMessage = "Passwords do not match"
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
        }
        .padding()
    }
}

/// Preview provider to assist in designing and testing the AccountView.
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(AccountController(forTesting: true))
    }
}
