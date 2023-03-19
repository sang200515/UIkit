//
//  CheckInOutEndpoint.swift
//  fptshop
//
//  Created by Sang Trương on 09/06/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

enum CheckInOutEndPoint {
    case getUserKiemTraInOut(p_UserCode : String)
    case getUserCheckInOut(p_UserCode : String,p_CheckType : Int)
}

extension CheckInOutEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getUserKiemTraInOut,
                .getUserCheckInOut:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        
        switch self {
        case .getUserKiemTraInOut:
            return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/UserKiemTraInOut"
        case .getUserCheckInOut:
            return BASE_URL + "/mpos-cloud-msm/mSM/Service.svc/UserCheckInOut"
        }
    }

    var parameters: JSONDictionary {
        switch self {
        case .getUserKiemTraInOut(let p_UserCode):
            return  [
                "p_UserCode": p_UserCode,
            ]
        case .getUserCheckInOut(let p_UserCode,let p_CheckType):
            return  [
                "p_UserCode": p_UserCode,
                "p_CheckType": p_CheckType,
            ]

        }
    }
}
