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
        self.stackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                               leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                               bottom: nil,
                               trailing: self.view.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 10, left: 20, bottom: 0, right: -20))
        
        self.userFullNameLabel.numberOfLines = 0
        self.emailLabel.numberOfLines = 0
    }
    
    fileprivate func populateDetails() {
        self.userFullNameLabel.text = self.viewModel.fullName
        self.emailLabel.text = self.viewModel.email
        self.idLabel.text = self.viewModel.id
    }
}
