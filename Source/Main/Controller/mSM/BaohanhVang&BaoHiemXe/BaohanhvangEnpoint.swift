//
//  BaohanhvangEnpoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

enum BaohanhEnpoint {
    case getBaoHanhVang(type: BaoHanhType)
    case getBaoHiemXe(type: BaoHanhType)
}

extension BaohanhEnpoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
            return .post
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getBaoHanhVang(let type):
            switch type {
            case .vangShop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHanhVang_Shop"
            case .vangVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHanhVang_Vung"
            case .vangKhuvuc:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHanhVang_KhuVuc"
            default:
                return ""
            }
        case .getBaoHiemXe(let type):
            switch type {
            case .xeShop:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHiemXe_Shop"
            case .xeVung:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHiemXe_Vung"
            case .xeKhuVuc:
                return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/BaoHiemXe_KhuVuc"
            default:
                return ""
            }
        }
    }
    
    var parameters: JSONDictionary {
        return ["p_UserCode": Cache.user!.UserName,
                "p_Token": Cache.user!.Token]
    }
}
