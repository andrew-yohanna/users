//
//  DUUsersViewModel.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

class DUUsersViewModel {
    var apiService: DUApiServiceProtocol!
    var itemViewModels: [DUUserCellViewModel] = []
    var errorMessage: String? = nil
    
    // Binding closure to update the UI Component when ViewModel object values are changed using this viewModel
    var reloadItems: (()->())?
    
    // Binding closure to update the UI component when an error occurs
    var showErrorMessage: (()->())?
    
    init(with apiService: DUApiServiceProtocol) {
        self.apiService = apiService
    }
    
    /// Fetching all locations and reloads the bound components
    func fetchUsers() {
        self.apiService.fetchAllUsers{ [weak self] (result) in
            guard let result = result else { return }
            switch result {
            case .success(let locations):
                self?.itemViewModels = locations.compactMap { return DUUserCellViewModel.init(with: $0) }
                self?.reloadItems?()
            case .failure(let error):
                self?.errorMessage = Labels.noUsersErrorMessage.rawValue
                self?.showErrorMessage?()
                print(error.localizedDescription)
            }
        }
    }
}
