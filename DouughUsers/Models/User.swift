//
//  User.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
}

extension User {
    func compare(with user: User,using sortingOption: SortingOption = .firstName)  -> Bool {
        switch sortingOption {
        case .firstName:
            return self.firstName.lowercased() < user.firstName.lowercased()
        case .lastName:
            return self.lastName.lowercased() < user.lastName.lowercased()
        case .id:
            return self.id < user.id
        }
    }
}
