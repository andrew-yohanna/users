//
//  DUHttpClient.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

/// Result enum to show whether it is a success or failure, and the object to be returned
///
/// - success: holds the result object
/// - failure: holds the result error
enum Result<T> {
    case success(T)
    case failure(Error)
}

/// Protocol for URLSession to return codable and raw data objects
protocol DUCodableURLSessionProtocol {
    func codableDataTask<T: Codable>(with urlRequest: URLRequest, completionHandler: @escaping (Result<T>) -> Void) -> DUURLSessionDataTaskProtocol
}


/// Protocol to wrapping DataTask for mocking purposes mainly
protocol DUURLSessionDataTaskProtocol {
    func resume()
}

/// Protocol for our http client declaring methods needed in our api service
protocol DUHttpClientProtocol {
    func request<T: Codable>(with request: DURequestData, completionHandler: @escaping (Result<T>) -> Void)
}

// MARK: HttpClient Implementation
class DUHttpClient: DUHttpClientProtocol {
    private let session: DUCodableURLSessionProtocol
    
    init(session: DUCodableURLSessionProtocol) {
        self.session = session
    }
    
    func request<T: Codable>(with request: DURequestData, completionHandler: @escaping (Result<T>) -> Void) {
        guard let url = URL(string: request.url) else {
            completionHandler(Result.failure(NSError(domain: "Invalid Url", code: 0, userInfo: nil)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        let task = session.codableDataTask(with: urlRequest) { (result) in
            completionHandler(result)
        }
        
        task.resume()
    }
}

// MARK: Conform the protocols
extension URLSessionDataTask: DUURLSessionDataTaskProtocol {}

// Extending the URLSession to conform to the codable protocol that retrieves the results in a generic Result object
extension URLSession: DUCodableURLSessionProtocol {
    func codableDataTask<T: Codable>(with urlrequest: URLRequest, completionHandler: @escaping (Result<T>) -> Void) -> DUURLSessionDataTaskProtocol {
        return self.dataTask(with: urlrequest) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(Result.failure(error!))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let t = try? decoder.decode(T.self, from: data)
            guard t == nil else {
                completionHandler(Result.success(t!))
                return
            }
            completionHandler(Result.failure(NSError(domain: "Invalid Url", code: 0, userInfo: nil)))
        }
    }
}
