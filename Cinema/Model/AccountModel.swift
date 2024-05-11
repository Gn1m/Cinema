//
//  AccountModel.swift
//  Cinema
//
//  Created by Kevin Han on 12/5/2024.
//

import Foundation

struct AccountModel: Identifiable {
    var id = UUID()
    var username: String
    var account: String
    var password: String
}
