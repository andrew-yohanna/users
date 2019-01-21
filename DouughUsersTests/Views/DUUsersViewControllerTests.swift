//
//  DUUsersViewControllerTests.swift
//  DouughUsersTests
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import XCTest
@testable import DouughUsers
class DUUsersViewControllerTests: XCTestCase {
    var sut: DUUsersViewController!
    let mockAPIService = MockApiService()
   
    fileprivate func loadViewController() {
        self.sut = DUUsersViewController()
        sut.viewModel = DUUsersViewModel(with: mockAPIService)
        _ = sut.view // to call viewDidLoad
    }
    
    override func setUp() {
        mockAPIService.completionUsersResult = Result.success(UsersStubGenerator().stubUsers())
        loadViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_initialization() {
        XCTAssertEqual(sut.title, "All Users")
        XCTAssertEqual(sut.activityIndicatorView.isAnimating, true)
    }
    
    func test_showing_correct_users() {
        let expect = XCTestExpectation(description: "fetching users")
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0), 3)
            
            self.sut.tableView.frame = CGRect(x: 0, y: 0, width: 320, height: 480) // force load table view
            
            let cell1 = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! DUUserTableViewCell
            XCTAssertEqual("Bob Ong", cell1.userNameLabel.text)
            
            let cell2 = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! DUUserTableViewCell
            XCTAssertEqual("Benjamin Joseph Mark John Peter Simon Luke Chiong", cell2.userNameLabel.text)
            
            XCTAssertEqual(self.sut.activityIndicatorView.isAnimating, false)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
    
    func test_showing_fail_message() {
        mockAPIService.completionUsersResult = Result.failure(NSError(domain: "Fake Domain", code: 403, userInfo: nil))
       
        loadViewController()
        
        let expect = XCTestExpectation(description: "fetching users")
        
        DispatchQueue.main.async {
            if let noDataLabel = self.sut.tableView!.backgroundView as? UILabel {
                XCTAssertEqual(noDataLabel.text, "Error in loading users. Please try again")
            } else {
                XCTFail()
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
}

