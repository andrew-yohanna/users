//
//  DUApiService.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation
/// The Api Service Protocol to declare our service endpoints
protocol DUApiServiceProtocol {
    func fetchAllUsers(completionHandler: @escaping (Result<[User]>?) -> Void)
}

/// The Api Service struct implementing on our end points.
///
/// Initialized with an injected DUHttpClientProtocol object
struct DUApiService: DUApiServiceProtocol {
    static let baseUrl = "https://gist.githubusercontent.com/douughios/f3c382f543a303984c72abfc1d930af8/raw/5e6745333061fa010c64753dc7a80b3354ae324e"
    let httpClient: DUHttpClientProtocol
    
    init(with httpClient: DUHttpClientProtocol = DUHttpClient(session: URLSession.shared)) {
        self.httpClient = httpClient
    }
    
    func fetchAllUsers(completionHandler: @escaping (Result<[User]>?) -> Void) {
        let url = DUApiService.baseUrl + "/test-users.json"
        let requestData = DURequestData(httpMethod: .get, url: url)
        httpClient.request(with: requestData) { (result) in
            completionHandler(result)
        }
    }
}
