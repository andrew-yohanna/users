//
//  DUUserDetailsViewControllerTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 22/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers

class DUUserDetailsViewControllerTests: XCTestCase {
    var sut: DUUserDetailsViewController!
    var mockUser = User(id: 1, firstName: "John", lastName: "Snow", email: "john.snow@winterfell.got")
    
    fileprivate func loadViewController() {
        self.sut = DUUserDetailsViewController()
        sut.viewModel = DUUserDetailsViewModel(with: mockUser)
        _ = sut.view // to call viewDidLoad
    }
    
    override func setUp() {
        loadViewController()
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_initialization() {
        XCTAssertEqual(sut.title, "User Details")
        XCTAssertEqual(sut.userFullNameLabel.text, "John Snow")
        XCTAssertEqual(sut.emailLabel.text, "john.snow@winterfell.got")
        XCTAssertEqual(sut.idLabel.text, "ID: 1")
    }
}
