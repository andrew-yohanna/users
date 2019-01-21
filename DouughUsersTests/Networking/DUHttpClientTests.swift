//
//  DUHttpClientTests.swift
//  Douugh PeopleTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class DUHttpClientTests: XCTestCase {
    var sut: DUHttpClient!
    var mockupSession: MockupCodableURLSession!
    
    override func setUp() {
        super.setUp()
        mockupSession = MockupCodableURLSession()
        sut = DUHttpClient(session: mockupSession)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_get_request_withURL() {
        let requestData = DURequestData(httpMethod: .get, url: "https://mockurl")
        guard let url = URL(string: requestData.url) else {
            fatalError("URL can't be empty")
        }
        
        sut.request(with: requestData) { (result: Result<MockObject>) in
        }
        
        // Assert
        XCTAssertEqual(url, mockupSession.lastURL)
    }
    
    func test_get_resume_called() {
        let dataTask = MockDataTask()
        mockupSession.dataTask = dataTask
        let requestData = DURequestData(httpMethod: .get, url: "https://mockurl")
        
        sut.request(with: requestData) { (result: Result<MockObject>) in
        }
        
        // Assert
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_correct_mock_object_returned() {
        let mockObject = MockObject(displayName: "Mock Object 2")
        let requestData = DURequestData(httpMethod: .get, url: "https://mockurl")
        let expect = XCTestExpectation(description: "get codable result triggered")
        mockupSession.mockObject = mockObject
        sut.request(with: requestData) { (result: Result<MockObject>) in
            switch result {
            case .success(let resultMockObject):
                XCTAssertEqual(resultMockObject.displayName, mockObject.displayName)
            case .failure:
                XCTFail()
            }
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1.0)
    }
}
