//
//  MockupCodableURLSession.swift
//  DouughPeopleTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
@testable import DouughUsers

struct MockObject: Codable {
    let displayName: String
}

class MockupCodableURLSession: DUCodableURLSessionProtocol {
    var lastURL: URL?
    var dataTask = MockDataTask()
    var mockObject = MockObject(displayName: "")
    
    func codableDataTask<MockObject>(with urlRequest: URLRequest, completionHandler: @escaping (Result<MockObject>) -> Void) -> DUURLSessionDataTaskProtocol {
        self.lastURL = urlRequest.url
        let result : Result<MockObject> = Result.success(mockObject) as! Result<MockObject>
        completionHandler(result)
        return dataTask
    }
}

class MockDataTask: DUURLSessionDataTaskProtocol {
    var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
}
