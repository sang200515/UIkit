//
//  FollowZaloShopAPIService.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

enum FollowZaloShopAPIService {
    case getListCustomer(_ shopCode: String)
    case verify_ScanQR_Code_Zalo(_ qrCode: String)
    case update_info_customer_follow_zalo(_ params: [String:Any])
}

extension FollowZaloShopAPIService: TargetType {
    private static var _manager = Config.manager

    var baseURL: URL {
        switch self {
        case .getListCustomer:
            let urlString = FollowZaloShopAPIService._manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
            
        case .verify_ScanQR_Code_Zalo:
            let urlString = FollowZaloShopAPIService._manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        case .update_info_customer_follow_zalo:
//            let urlString = "http://internalapibeta.fptshop.com.vn:5021"
            let urlString = FollowZaloShopAPIService._manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getListCustomer:
            return "/internal-api-service/api/bot-ai/pos/get-sender"
        case .verify_ScanQR_Code_Zalo:
            return "/mpos-cloud-api/api/customer/mpos_FRT_Customer_follow_zalo_info"
        case .update_info_customer_follow_zalo:
            return "/internal-api-service/api/bot-ai/pos/update-sender"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getListCustomer, .verify_ScanQR_Code_Zalo:
            return .get
        case .update_info_customer_follow_zalo:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getListCustomer(let shopCode):
            let params: [String:Any] = [ "shopCode": shopCode]
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .verify_ScanQR_Code_Zalo(let qrCode):
            let params: [String:Any] = ["Docentry": qrCode]
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .update_info_customer_follow_zalo(let params):
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getListCustomer, .verify_ScanQR_Code_Zalo, .update_info_customer_follow_zalo:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
}
