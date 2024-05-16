//
//  AccountView.swift
//  Cinema
//
//  Created by Ming Z on 8/5/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var controller: AccountController
    @State private var showingUpdateEmail = false
    @State private var showingUpdatePassword = false
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(controller.currentUser == nil ? "Hello Guest" : "Hello \(controller.currentUser!.username)")
                    .font(.largeTitle)
                    .padding()
                            
                Spacer()

                if let currentUser = controller.currentUser {
                    VStack(spacing: 10) {
                        Text("Email: \(currentUser.email)")

                        Button("Update Email") {
                            showingUpdateEmail.toggle()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                        Button("Update Password") {
                            showingUpdatePassword.toggle()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                        Button("Log Out") {
                            controller.logout()
                            CinemaModelManager.shared.logout()  // Log out from CinemaModelManager as well
                            OrderViewModel.shared.fetchOrders()  // Refresh orders after logging out
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                    }
                } else {
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
                VStack {
                    TextField("New Email", text: $newEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

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
            .sheet(isPresented: $showingUpdatePassword) {
                VStack {
                    SecureField("New Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Update") {
                        if newPassword == confirmPassword {
                            if Validator.isValidPassword(newPassword) {
                                if let error = controller.updatePassword(newPassword: newPassword) {
                                    errorMessage = error
                                } else {
                                    showingUpdatePassword = false
                                }
                            } else {
                                errorMessage = "Password must be 6 digis and contain at least one uppercase letter and one lowercase letter"
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
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AccountController(forTesting: true))
    }
}
