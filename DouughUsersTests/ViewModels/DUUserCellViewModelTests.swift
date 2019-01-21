//
//  DUUserCellViewModelTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class DUUserCellViewModelTests: XCTestCase {
    
    var sut: DUUserCellViewModel!
    var mockUser = User(id: 1, firstName: "John", lastName: "Snow", email: "john.snow@winterfell.got")
    
    override func setUp() {
        super.setUp()
        sut = DUUserCellViewModel.init(with: mockUser)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertEqual(sut.fullName, "John Snow")
        XCTAssertEqual(sut.email, "john.snow@winterfell.got")
    }
}
