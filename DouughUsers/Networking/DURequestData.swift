//
//  DURequestData.swift
//  DouughUsers
//
//  Created by Andrew Yohanna on 21/1/19.
//  Copyright © 2019 Andrew Yohanna. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}


/// Declares Request Data object
///
/// Contains all the elements of the request object.
/// For now, it contains what is needed; httpMethod and url.
/// Parameters and headers to be added.
struct DURequestData {
    let httpMethod: HttpMethod
    let url: String
}
