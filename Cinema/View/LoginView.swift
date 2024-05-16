//
//  LoginView.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var controller: AccountController
    @Environment(\.presentationMode) var presentationMode
    @State private var accountOrEmail = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Account or Email", text: $accountOrEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: accountOrEmail) { _ in showError = false }

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: password) { _ in showError = false }

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Login") {
                if let error = controller.login(accountOrEmail: accountOrEmail, password: password) {
                    errorMessage = error
                    showError = true
                } else {
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
        .navigationBarTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AccountController(forTesting: true))
    }
}
