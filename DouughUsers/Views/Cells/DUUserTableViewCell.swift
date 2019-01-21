//
//  DUUserTableViewCell.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

class DUUserTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 80
    static let cellPadding: CGFloat = 8
    
    let containerView = UIView()
    let userNameLabel = UILabel()
    
    var viewModel: DUUserCellViewModel? { didSet {
        self.userNameLabel.text = self.viewModel!.fullName
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
        self.addSubview(self.containerView)
        self.containerView.addSubview(userNameLabel)
        self.containerView.backgroundColor = .white
        self.containerView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                                  leading: self.safeAreaLayoutGuide.leadingAnchor,
                                  bottom: self.safeAreaLayoutGuide.bottomAnchor,
                                  trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                  padding: .init(top: DUUserTableViewCell.cellPadding,
                                                 left: DUUserTableViewCell.cellPadding,
                                                 bottom: -DUUserTableViewCell.cellPadding,
                                                 right: -DUUserTableViewCell.cellPadding))
        
        self.userNameLabel.anchor(top: self.containerView.topAnchor,
                                      leading: self.containerView.leadingAnchor,
                                      bottom: self.containerView.bottomAnchor,
                                      trailing: self.containerView.trailingAnchor,
                                      padding: .init(top: DUUserTableViewCell.cellPadding,
                                                     left: DUUserTableViewCell.cellPadding,
                                                     bottom: -DUUserTableViewCell.cellPadding,
                                                     right: -DUUserTableViewCell.cellPadding))
        
        self.userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.userNameLabel.textAlignment = .left
        
        self.accessoryType = .disclosureIndicator
    }
}
