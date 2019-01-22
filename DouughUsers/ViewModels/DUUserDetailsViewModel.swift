//
//  DUUserDetailsViewModel.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

class DUUserDetailsViewModel {
    let user: User
    let fullName: String
    let email: String
    let id: String
    
    init(with user: User) {
        self.user = user
        self.fullName = user.firstName + " " + user.lastName
        self.email = user.email
        self.id = "ID: \(user.id)"
    }
}
