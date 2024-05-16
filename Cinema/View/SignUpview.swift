//
//  SignUpview.swift
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
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            if password != confirmPassword {
                Text("Your password does not match!")
                        .font(.caption)
                        .foregroundColor(.red)
                        }

            Button("Sign Up") {
                if password == confirmPassword {
                    controller.signUp(username: username, account: account, password: password)
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
        .navigationBarTitle("Sign Up")
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AccountController())
    }
}

