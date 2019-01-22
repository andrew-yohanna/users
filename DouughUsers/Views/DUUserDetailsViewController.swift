//
//  DUUserDetailsViewController.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit
import MapKit

class DUUserDetailsViewController: UIViewController {
    var viewModel: DUUserDetailsViewModel!
    
    lazy var stackView = UIStackView()
    lazy var userFullNameLabel = UILabel()
    lazy var emailLabel = UILabel()
    lazy var idLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.populateDetails()
    }
    
    fileprivate func setupViews() {
        self.title = Labels.userDetails.rawValue
        self.view.backgroundColor = .white
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.userFullNameLabel)
        self.stackView.addArrangedSubview(self.emailLabel)
        self.stackView.addArrangedSubview(self.idLabel)
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 20
        self.stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
        
        self.userFullNameLabel.numberOfLines = 0
        self.userFullNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.emailLabel.numberOfLines = 0
        self.emailLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.idLabel.numberOfLines = 0
        self.idLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    fileprivate func populateDetails() {
        self.userFullNameLabel.text = self.viewModel.fullName
        self.emailLabel.text = self.viewModel.email
        self.idLabel.text = self.viewModel.id
    }
}
