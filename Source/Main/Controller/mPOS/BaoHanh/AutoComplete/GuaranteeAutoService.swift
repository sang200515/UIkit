//
//  GuaranteeAutoService.swift
//  fptshop
//
//  Created by Ngoc Bao on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Moya


enum GuaranteeAutoService {
    case LoadLichSuTestMay_Mobile(params: [String: Any])
    case LoadThongTinTestMay_Mobile(params: [String: Any])
    case Luu_XoaTestMay(params: [String: Any])
}

extension GuaranteeAutoService: TargetType {
    var path: String {
        switch self {
        case .LoadLichSuTestMay_Mobile:
            return "/wrt-service/api/warranty/search/LoadLichSuTestMay_Mobile"
        case .LoadThongTinTestMay_Mobile:
            return "/wrt-service/api/warranty/search/LoadThongTinTestMay_Mobile"
        case .Luu_XoaTestMay:
            return "/wrt-service/api/warranty/create/Luu_XoaTestMay"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .LoadThongTinTestMay_Mobile(let params),.LoadLichSuTestMay_Mobile(let params),.Luu_XoaTestMay(let params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .LoadLichSuTestMay_Mobile, .LoadThongTinTestMay_Mobile, .Luu_XoaTestMay:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
    var baseURL: URL {
        switch self {
        case .LoadLichSuTestMay_Mobile, .LoadThongTinTestMay_Mobile, .Luu_XoaTestMay:
            let urlString = Config.manager.URL_GATEWAY!
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
}

