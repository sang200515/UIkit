//
//  ThaySimItelEndpoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ThaySimItelEndpoint {
    case getOtp(phone: String,name: String,birthday:String,cmnd: String,dateCmnd: String)
    case changeSimhong(Msisdn: String,Seri: String,Esim: String,Doctal: String,FullName: String,Otp: String)
}

extension ThaySimItelEndpoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
            return .post
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        
        switch self {
        case .getOtp:
            return BASE_URL + "/mpos-cloud-api/api/Sim/Itel_SendOTPUpdateSimHong"
        case .changeSimhong:
            return BASE_URL + "/mpos-cloud-api/api/Sim/Itel_ChangeIsimHong"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getOtp(let phone,let  name,let birthday,let  cmnd,let  dateCmnd):
            return [
                "Msisdn": phone,
                "FullName": name,
                "Birthday": birthday,
                "Idnumber": cmnd,
                "PlaceDate": dateCmnd,
                "UserCode": Cache.user!.UserName,
                "ShopCode": Cache.user!.ShopCode
            ]
        case .changeSimhong(let Msisdn,let Seri,let Esim,let Doctal,let FullName, let Otp):
            return [
                "Msisdn": Msisdn,
                  "Seri": Seri,
                  "Esim": Esim,
                  "Doctal": Doctal,
                  "FullName": FullName,
                  "GhiChu": "Đổi sim thuê bao \(Msisdn) sang serial \(Seri)",
                "Otp": Otp,
                "UserCode": Cache.user!.UserName,
                  "ShopCode": Cache.user!.ShopCode,
                  "ShopName": Cache.user!.ShopName,
                  "ShopAddress": Cache.user!.ShopName,
                  "DeviceType": "2",
                  "Version": Common.versionApp()
            ]
        }
    }
}
