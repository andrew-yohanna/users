//
//  MockupHttpClient.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
@testable import DouughUsers

class MockupHttpClient: DUHttpClientProtocol {
    var isGetCalled = false
    var lastURLString = ""
    
    var mockObject: Any?
    var mockError: Error = NSError(domain: "Fake Domain", code: 403, userInfo: nil)
    
    func request<T: Codable>(with requestData: DURequestData, completionHandler: @escaping (Result<T>) -> Void) {
        self.isGetCalled = true
        self.lastURLString = requestData.url
        let result: Result<T>
        if mockObject != nil {
            let resultObject = mockObject as! T
            result = Result.success(resultObject)
        } else {
            result = Result.failure(mockError)
        }
        completionHandler(result)
    }
}
