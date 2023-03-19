//
//  HangHotEndPoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 29/09/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

enum HangHotEndPoint {
    case getHangHotData(type:HangHotType)
}

extension HangHotEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
            return .post
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getHangHotData(let type):
            switch type {
            case .realtimeVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyleHTTargetHH_Realtime_Vung_View"
            case .realtimeshop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyleHTTargetHH_Realtime_Shop_View"
            case .realtimeKhuvuc:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyleHTTargetHH_Realtime_KhuVuc_View"
            case .luykeASM:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyLeHTTargetHangHot_ASM"
            case .luykeShop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyLeHTTargetHangHot_TheoShop"
            case .luykeVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/TyLeHTTargetHangHot_Vung"
            case .none:
                return ""
            }
        }
    }
    
    var parameters: JSONDictionary {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        let month = calendar.component(.month, from: Date())
        switch self {
        case .getHangHotData(let type):
            switch type {
            case .realtimeshop,.realtimeKhuvuc,.realtimeVung:
                return ["p_UserCode": Cache.user!.UserName,
                        "p_Token": Cache.user!.Token]
            case .luykeShop,.luykeVung,.luykeASM:
                return ["p_UserCode": Cache.user!.UserName,
                        "p_Token": Cache.user!.Token,
                        "p_Month": month,
                        "p_Year": year
                        ]
            case .none:
                return [:]
            }
//        default:
//            return [:]
        }
    }
}
