//
//  DUUserTableViewCell.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class DUUserTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 90
    static let cellPadding: CGFloat = 20
    
    lazy var stackView = UIStackView()
    lazy var userNameLabel = UILabel()
    lazy var emailLabel = UILabel()

    var viewModel: DUUserCellViewModel? { didSet {
        guard self.viewModel != nil else {
            return
        }
        
        self.userNameLabel.text = self.viewModel!.fullName
        self.emailLabel.text = self.viewModel!.email
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .clear
        self.addSubview(self.stackView)
        self.stackView.backgroundColor = .white
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                                  leading: self.safeAreaLayoutGuide.leadingAnchor,
                                  bottom: self.safeAreaLayoutGuide.bottomAnchor,
                                  trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                  padding: .init(top: DUUserTableViewCell.cellPadding,
                                                 left: DUUserTableViewCell.cellPadding,
                                                 bottom: -DUUserTableViewCell.cellPadding,
                                                 right: -DUUserTableViewCell.cellPadding))
        
        self.stackView.addArrangedSubview(self.userNameLabel)
        self.stackView.addArrangedSubview(self.emailLabel)

        self.userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.userNameLabel.textAlignment = .left
        self.userNameLabel.numberOfLines = 0
        self.emailLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        self.emailLabel.textAlignment = .left
        self.emailLabel.numberOfLines = 0
        
        self.accessoryType = .disclosureIndicator
    }
}
