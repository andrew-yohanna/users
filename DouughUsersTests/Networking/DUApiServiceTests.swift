//
//  DUApiServiceTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class DUApiServiceTests: XCTestCase {
    var sut: DUApiService!
    var mockupHttpClient: MockupHttpClient!
    var mockupSession: MockupCodableURLSession!
    let mockUser = User(id: 1, firstName: "John", lastName: "Snow", email: "john.snow@winterfell.got")
    
    override func setUp() {
        super.setUp()
        mockupSession = MockupCodableURLSession()
        mockupHttpClient = MockupHttpClient()
        sut = DUApiService(with: mockupHttpClient)
    }
    
    override func tearDown() {
        mockupSession = nil
        mockupHttpClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_all_users_called_get_with_url() {
        self.mockupHttpClient.mockObject = [mockUser]
        let expect = XCTestExpectation(description: "get result triggered")
        sut.fetchAllUsers { result in
            switch result! {
            case .success(let resultMockObject):
                XCTAssertEqual(resultMockObject[0].firstName, self.mockUser.firstName)
            case .failure:
                XCTFail()
            }
            expect.fulfill()
        }
        
        XCTAssertEqual(mockupHttpClient.lastURLString, "https://gist.githubusercontent.com/douughios/f3c382f543a303984c72abfc1d930af8/raw/5e6745333061fa010c64753dc7a80b3354ae324e/test-users.json")
        XCTAssertEqual(mockupHttpClient.isGetCalled, true)
        wait(for: [expect], timeout: 1.0)
    }
    
    func test_fetch_all_users_failed() {
        self.mockupHttpClient.mockObject = nil
        let expect = XCTestExpectation(description: "get result triggered")
        sut.fetchAllUsers { result in
            switch result! {
            case .success:
                XCTFail()
            case .failure(let mockError):
                XCTAssertEqual(mockError as NSError, NSError(domain: "Fake Domain", code: 403, userInfo: nil))
            }
            expect.fulfill()
        }
        
        XCTAssertEqual(mockupHttpClient.lastURLString, "https://gist.githubusercontent.com/douughios/f3c382f543a303984c72abfc1d930af8/raw/5e6745333061fa010c64753dc7a80b3354ae324e/test-users.json")
        XCTAssertEqual(mockupHttpClient.isGetCalled, true)
        wait(for: [expect], timeout: 1.0)
    }
}
