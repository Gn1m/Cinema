//
//  AccountView.swift
//  Cinema
//
//  Created by Ming Z on 8/5/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var controller: AccountController

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(controller.currentUser == nil ? "Hello Guest" : "Hello \(controller.currentUser!.username)")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()

                if controller.currentUser != nil {
                    Button("Log Out") {
                        controller.currentUser = nil
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                } else {
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: LoginView()) {
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
        }
    }
}



struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AccountController())
    }
}
