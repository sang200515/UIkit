//
//  NewCheckVersionAPIService.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import UIKit
import Moya

enum NewCheckVersionAPIService {
    case newCheckVersion(_ params: [String:Any])
}

extension NewCheckVersionAPIService: TargetType {
    var baseURL: URL {
        switch self {
        case .newCheckVersion:
            if Config.manager.version == "Production" {
                let urlString = Config.manager.URL_GATEWAY!
                guard let url = URL(string: urlString) else {
                    fatalError("Could not get Myinfo base URL")
                }
                return url
            } else {
                let urlString = "https://mposapibeta.fptshop.com.vn:2020/"
                guard let url = URL(string: urlString) else {
                    fatalError("Could not get Myinfo base URL")
                }
                return url
            }
        }
    }
    
    var path: String {
        switch self {
        case .newCheckVersion:
            if Config.manager.version == "Production" {
                return "mpos-cloud-api/api/notification/sp_mpos_oneapp_get_version"
            } else {
                return "api/notification/sp_mpos_oneapp_get_version"
            }
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newCheckVersion:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .newCheckVersion(let params):
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .newCheckVersion:
            return ["Content-Type":"application/json",
                    "Authorization": "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
}
