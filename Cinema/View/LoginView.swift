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
    @State private var account = ""
    @State private var password = ""
    @State private var showError = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: account) { _ in showError = false }
                

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: account) { _ in showError = false }

            if showError {
                Text("Wrong password")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Login") {
                if let user = controller.login(account: account, password: password) {
                    controller.currentUser = user
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showError = true
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






