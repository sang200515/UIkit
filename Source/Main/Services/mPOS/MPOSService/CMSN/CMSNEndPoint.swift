//
//  CMSNEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

enum CMSNEndPoint {
    case getCMSNHistories
    case cancelCMSNVoucher(id: Int)
}

extension CMSNEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getCMSNHistories:
            return .get
        default:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        
        switch self {
        case .getCMSNHistories:
            return BASE_URL + "/mpos-cloud-api/api/Customer/BirthdayOnMarchHistory"
        case .cancelCMSNVoucher:
            return BASE_URL + "/mpos-cloud-api/api/Customer/CancelBirthdayOnMarchVoucher"
        }
    }

    var parameters: JSONDictionary {
        switch self {
        case .getCMSNHistories:
            return  ["userCode": Cache.user!.UserName,
                     "shopCode": Cache.user!.ShopCode]
        case .cancelCMSNVoucher(let id):
            return ["userCode": Cache.user!.UserName,
                    "shopCode": Cache.user!.ShopCode,
                    "voucherId": id]
        default:
            return [:]
        }
    }
}
