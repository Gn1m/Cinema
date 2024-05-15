//
//  AccountView.swift
//  Cinema
//
//  Created by Ming Z on 8/5/2024.
//

import SwiftUI

// View to display and manage the user's account details
struct AccountView: View {
    @EnvironmentObject var controller: AccountController // Use EnvironmentObject to access the shared instance of AccountController

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Display greeting message based on user login status
                Text(controller.currentUser == nil ? "Hello Guest" : "Hello \(controller.currentUser!.username)")
                    .font(.largeTitle)
                    .padding()
                
                Spacer() // Push content to the top
                
                // If the user is logged in, show Log Out button
                if controller.currentUser != nil {
                    Button("Log Out") {
                        controller.currentUser = nil // Log out the user
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red) // Red background for Log Out button
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
                    .padding(.horizontal)
                } else {
                    // If the user is not logged in, show Sign Up and Login buttons
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue) // Blue background for Sign Up button
                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green) // Green background for Login button
                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarTitle("Account", displayMode: .inline) // Inline title display mode
            .padding()
        }
    }
}

// Preview provider to display the AccountView in Xcode previews
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AccountController()) // Provide a mock AccountController for the preview
    }
}
