//
//  UserviceAPIServies.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

enum UserviceAPIServices {
    case getListGroupFeature(_ params: [String:Any])
    case createTicketUservice(_ params: [String:Any])
    case uploadImageFile(_ params: [String:Any])
    case getListHistoryUservice(_ params: [String:Any])
}

extension UserviceAPIServices : TargetType {
    
    private static var _manager = Config.manager
    
    var baseURL: URL {
        switch self {
        case .getListGroupFeature, .uploadImageFile, .getListHistoryUservice:
            let urlString = UserviceAPIServices._manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
            
        case .createTicketUservice:
            let urlString = UserviceAPIServices._manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getListGroupFeature:
            return "/internal-api-service/api/frt-uservice/API/HoTroNguoiDung87333/DanhSachChucNang"
        case .createTicketUservice:
            return "/internal-api-service/api/frt-uservice/API/Ticket/Create"
        case .uploadImageFile:
            return "/internal-api-service/api/frt-uservice/API/AttachFile/Upload"
        case .getListHistoryUservice:
            return "/internal-api-service/api/frt-uservice/API/UService/GetTicketHistory"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getListGroupFeature:
            return .get
        case .createTicketUservice, .uploadImageFile, .getListHistoryUservice:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getListGroupFeature(let params):
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .createTicketUservice(let params), .uploadImageFile(let params), .getListHistoryUservice(let params):
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getListGroupFeature, .uploadImageFile, .getListHistoryUservice:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
            
        case .createTicketUservice:
            return [
                "Content-Type":"application/json",
                "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
}


