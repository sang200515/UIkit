//
//  ShinHanOTPEndpoint.swift
//  QuickCode
//
//  Created by Sang Trương on 15/09/2022.
//

import Foundation
import Alamofire

enum ShinHanOTPEndpoint {
    case getOTP(mposNumber : String)
    case verifyOTP(mposNumber : String,OTP : String)

}

extension ShinHanOTPEndpoint: EndPointType {

    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .getOTP:
                return .get
            case .verifyOTP:
                return .post
        }
    }
    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        switch self {
            case .getOTP(let mposNumber):   
                return BASE_URL + "/mpos-cloud-api" +  "/api/Shinhan/GetOTPShinhan?Usercode=\(Cache.user!.UserName)&Shopcode=\(Cache.user!.ShopCode)&MposNum=\(mposNumber)"
            case .verifyOTP:
                return BASE_URL + "/mpos-cloud-api" +  "/api/Shinhan/VerifyOTPShinhan"

        }
    }

    var parameters: JSONDictionary {
        switch self {
            case .getOTP:
                return  [ : ]

            case .verifyOTP(let mposNumber, let OTP):
                return [
                    "Usercode": "\(Cache.user!.UserName)",
                    "Shopcode": "\(Cache.user!.ShopCode)",
                    "MposNum": mposNumber,
                    "OTP": OTP,
                ]

        }
    }
}
