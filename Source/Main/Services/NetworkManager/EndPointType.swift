//
//  EndPointType.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

let limitLoad = 20
typealias JSONDictionary = [String: Any]

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: JSONDictionary { get }
    var headers: HTTPHeaders? { get }
}

struct DefaultHeader {
    func addAuthHeader() -> HTTPHeaders {
        var access_token = UserDefaults.standard.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers: HTTPHeaders = ["Content-type": "application/json", "Authorization": "Bearer \(access_token!)"]
        return headers
    }
    func addAuthHeaderEbay() -> HTTPHeaders {
        let access_token = UserDefaults.standard.string(forKey: "access_token")

        let headers: HTTPHeaders = ["Content-type": "application/json", "Authorization": "Bearer \(access_token!)","X-Som-Provider-Id":"D01606AC-0BD8-4D76-984D-5611BDB419CE"]
        return headers
    }
}
