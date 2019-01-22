//
//  UserTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 22/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class UserTests: XCTestCase {
    var sut = User(id: 1, firstName: "John", lastName: "Snow", email: "john.snow@winterfell.got")

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func test_compare_default() {
        let user1 = User(id: 0, firstName: "Ned", lastName: "Stark", email: "ned.stark@winterfell.got")
        XCTAssert(sut.compare(with: user1))
        
        let user2 = User(id: 3, firstName: "Arya", lastName: "Stark", email: "arya.stark@winterfell.got")
        XCTAssertFalse(sut.compare(with: user2))
    }
    
    func test_compare_with_sorting_options() {
        let user1 = User(id: 0, firstName: "Ramsay", lastName: "Bolton", email: "ramsay.bolton@dreadfort.got")
        XCTAssert(sut.compare(with: user1, using: .firstName))
        XCTAssertFalse(sut.compare(with: user1, using: .lastName))
        XCTAssertFalse(sut.compare(with: user1, using: .id))
        
        let user2 = User(id: 3, firstName: "Daenerys", lastName: "Targaryen", email: "Daenerys.Targaryen@dragonstone.got")
        XCTAssertFalse(sut.compare(with: user2, using: .firstName))
        XCTAssertTrue(sut.compare(with: user2, using: .lastName))
        XCTAssertTrue(sut.compare(with: user2, using: .id))
    }
}
