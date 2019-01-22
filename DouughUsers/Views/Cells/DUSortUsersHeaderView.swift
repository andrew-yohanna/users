//
//  DUSortUsersHeaderView.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 22/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit

enum SortingOption: String, CaseIterable {
    case firstName = "First"
    case lastName = "Last"
    case id = "ID"
}

protocol DUSortUsersHeaderViewDelegateProtocol {
    func sort(by sortingOption: SortingOption)
}

class DUSortUsersHeaderView: UITableViewHeaderFooterView {
    var delegate: DUSortUsersHeaderViewDelegateProtocol? = nil
    var selectedSegmentIndex = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    fileprivate func setupView() {
        let sortingSegmentedControl = UISegmentedControl(items: SortingOption.allCases.map { $0.rawValue })
        sortingSegmentedControl.selectedSegmentIndex = selectedSegmentIndex
        sortingSegmentedControl.addTarget(self, action: #selector(DUSortUsersHeaderView.sortingChanged(_:)), for: .valueChanged)
        self.addSubview(sortingSegmentedControl)
        sortingSegmentedControl.snp.makeConstraints { (make) in
            make.center.equalTo(self.safeAreaLayoutGuide.snp.center)
        }
    }
    
    @objc func sortingChanged(_ segment: UISegmentedControl) {
        self.selectedSegmentIndex = segment.selectedSegmentIndex
        let selectedSorting = SortingOption.allCases[selectedSegmentIndex]
        delegate?.sort(by: selectedSorting)
    }
}
