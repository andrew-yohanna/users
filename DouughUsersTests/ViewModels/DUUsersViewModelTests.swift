//
//  DUUsersViewModelTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class DUUsersViewModelTests: XCTestCase {
    var sut: DUUsersViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = DUUsersViewModel.init(with: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_all_users_called() {
        // When
        sut.fetchUsers()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchAllUsersCalled)
    }
    
    func test_fetch_all_users_success() {
        // Given
        mockAPIService.completionUsersResult = Result.success(UsersStubGenerator().stubUsers())
        let expect = XCTestExpectation(description: "reload items triggered")
        sut.reloadItems = { () in
            expect.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchAllUsersCalled)
        XCTAssertEqual(sut.itemViewModels.count, 3)
        XCTAssertEqual(sut.itemViewModels[0].fullName, "Bob Ong")
        XCTAssertEqual(sut.itemViewModels[0].email, "bob@ong.com")
        XCTAssertEqual(sut.itemViewModels[1].fullName, "Benjamin Joseph Mark John Peter Simon Luke Chiong")
        XCTAssertEqual(sut.itemViewModels[1].email, "benjamin_joseph_mark_john_peter_simon_luke@chiong.com")
        XCTAssertEqual(sut.itemViewModels[2].fullName, "Vaculo Semenka")
        XCTAssertEqual(sut.itemViewModels[2].email, "vaculo@semenka.com")
        
        // XCTAssert reload items triggered
        wait(for: [expect], timeout: 0.0)
    }
    
    func test_fetch_all_users_fail() {
        
        // Given a failed fetch with a certain failure
        mockAPIService.completionUsersResult = Result.failure(NSError(domain:"", code:400, userInfo:nil))
        let expect = XCTestExpectation(description: "reload items triggered")
        expect.isInverted = true
        sut.reloadItems = { () in
            expect.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Sut should display predefined error message
        XCTAssert(mockAPIService!.isFetchAllUsersCalled)
        XCTAssertEqual(sut.errorMessage!, "Error in loading users. Please try again")
        // XCTAssert reload items triggered
        wait(for: [expect], timeout: 0.0)
    }
    
//    func test_get_details_view_model() {
//        mockAPIService.completionUsersResult = Result.success(UsersStubGenerator().stubUsers())
//
//        fetchUsers()
//
//        let detailsViewModel = sut.detailsItemViewModel(at: 0)
//        XCTAssertEqual(detailsViewModel.locationName, "Rockdale NSW 2216, Australia")
//    }
}

class UsersStubGenerator {
    func stubUsers() -> [User] {
        let testBundle = Bundle(for: DUUsersViewModelTests.self)
        let path = testBundle.path(forResource: "users", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let users = try! decoder.decode([User].self, from: data)
        return users
    }
}
