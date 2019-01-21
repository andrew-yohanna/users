//
//  MockApiService.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
@testable import DouughUsers

class MockApiService:DUApiServiceProtocol {
    var isFetchAllUsersCalled = false
    
    var completionUsersResult: Result<[User]> = Result.success([])
   
    func fetchAllUsers(completionHandler: @escaping (Result<[User]>?) -> Void) {
        isFetchAllUsersCalled = true
        completionHandler(completionUsersResult)
    }
}
