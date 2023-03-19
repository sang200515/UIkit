//
//  ReplacementAccessoriesEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

enum ReplacementAccessoriesEndPoint {
    case getReplacementAccessories(sku: String)
}

extension ReplacementAccessoriesEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getReplacementAccessories:
            return .get
//        default:
//            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        
        switch self {
        case .getReplacementAccessories:
            return BASE_URL + "/internal-api-service/api/mpos/products_bundled"
        }
    }

    var parameters: JSONDictionary {
        switch self {
        case .getReplacementAccessories(let sku):
            return  ["sku": sku,
                     "shopcode": Cache.user!.ShopCode]
//        default:
//            return [:]
        }
    }
}
