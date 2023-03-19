//
//  GiaDungEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum GiaDungEndPoint {
    case getGiaDungData(type: GiaDungType,pType: Int)
}

extension GiaDungEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
            return .post
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getGiaDungData(let type,_):
            switch type {
            case .dailyVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Daily_Vung_View_Final"
            case .dailyShop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Daily_Shop_View_Final"
            case .dailyKhuvuc:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Daily_KhuVuc_View_Final"
            case .realtimeVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Realtime_Vung_View_Final"
            case .realtimeShop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Realtime_Shop_View_Final"
            case .realtimeKhuvuc:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/Baocaogiadung_Realtime_Khuvuc_View_Final"
            case .none:
                return ""
            }
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getGiaDungData(let type,let pType):
            switch type {
            case .dailyVung, .dailyShop, .dailyKhuvuc, .realtimeShop, .realtimeKhuvuc:
                return ["p_UserCode": Cache.user!.UserName,
                        "p_Token": Cache.user!.Token]
            case .realtimeVung:
                return ["p_UserCode": Cache.user!.UserName,
                        "p_Token": Cache.user!.Token,
                        "p_Type": pType
                ]
            case .none:
                return [:]
            }
        }
    }
}
