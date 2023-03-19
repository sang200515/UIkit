//
//  PaymentEndPoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 19/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftyJSON

enum PaymentEndPoint {
    case getRules(WalletCode: String,rdr1: String,promos: String)
}

extension PaymentEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
            return .post
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getRules:
            return BASE_URL + "/mpos-cloud-api/api/order/wallet_rule"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getRules(let WalletCode, let rdr1,let promos):
            return ["userCode": Cache.user!.UserName,
                    "shopCode": Cache.user!.ShopCode,
                    "RDR1": rdr1,
                    "PROMOS": promos,
                    "WalletCode": WalletCode]
        }
    }
}

class WalletRuleItem: Mappable {
    var isEnableChangeAmount: Bool = false
    var messages: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.isEnableChangeAmount <- map["isEnableChangeAmount"]
        self.messages <- map["messages"]
    }
}
