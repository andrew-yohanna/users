//
//  DUUsersViewController.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import UIKit
import SnapKit

/// Delegate to handle item selection as a DI
protocol DUUsersTableViewDelegateProtocol: class {
    func itemSelected(with detailsViewModel: DUUserDetailsViewModel)
}

class DUUsersViewController: UITableViewController {
    var viewModel: DUUsersViewModel!
    weak var delegate: DUUsersTableViewDelegateProtocol?

    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    lazy var headerView: DUSortUsersHeaderView = { 
        let headerView = DUSortUsersHeaderView()
        headerView.delegate = self
        return headerView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        setupViews()
        
        self.viewModel.reloadItems = { [weak self] () in
            DispatchQueue.main.async {
                // populating updated items and hiding the activity indicator view
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.showErrorMessage = { [weak self] () in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                // populating updated items and hiding the activity indicator view
                self.activityIndicatorView.stopAnimating()
                
                let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                noDataLabel.text = self.viewModel.errorMessage ?? "No data available"
                noDataLabel.textAlignment = .center
                self.tableView.backgroundView  = noDataLabel
                self.tableView.separatorStyle  = .none
            }
        }
        
        self.viewModel!.fetchUsers()
    }
    
    fileprivate func setupViews() {
        self.title = Labels.allUsers.rawValue
        
        self.tableView.addSubview(self.activityIndicatorView)
        
        self.activityIndicatorView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.tableView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.register(DUUserTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.userCell.rawValue)
        self.tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.itemViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.userCell.rawValue, for: indexPath) as! DUUserTableViewCell
        cell.viewModel = self.viewModel!.itemViewModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DUUserTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsItemViewModel = self.viewModel!.detailsItemViewModel(at: indexPath.row)
        self.delegate?.itemSelected(with: detailsItemViewModel)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// Conforming to the delegate protocol and handling item selection.
extension DUUsersViewController: DUUsersTableViewDelegateProtocol {
    func itemSelected(with detailsViewModel: DUUserDetailsViewModel) {
        let vc = DUUserDetailsViewController()
        vc.viewModel = detailsViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DUUsersViewController: DUSortUsersHeaderViewDelegateProtocol {
    func sort(by sortingOption: SortingOption) {
        self.viewModel.sort(by: sortingOption)
    }
}
