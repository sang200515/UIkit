//
//  InstallmentOnlineApimanager.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 05/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

class InstallmentApiManager {
    static let shared = InstallmentApiManager()
    var provider: MoyaProvider<InstallmentOnlineApiService> = MoyaProvider<InstallmentOnlineApiService>(plugins: [VerbosePlugin(verbose: true)])
    
    func getCustomerOrderHanding(phone: String = "",completion: @escaping ((CustomerOrderNew?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["employeeCode"] = Cache.user!.UserName
        params["shopCode"] = Cache.user?.ShopCode
        provider.request(.customerOrders(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = CustomerOrderNew.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    
    func getInstallmentDetail(params: [String: Any], completion: @escaping ((InstallmentOrderDetailBase?, String) ->Void)) {
        provider.request(.orderDerail(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = InstallmentOrderDetailBase.getObjFromDictionary(map: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func updateImei(params: [String: Any], completion: @escaping ((InstallmentBaseResponse?, String) ->Void)) {
        provider.request(.updateImei(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = InstallmentBaseResponse.getObjFromDictionary(map: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func checkInfordelivery(params: [String: Any], completion: @escaping ((InstallmentBaseResponse?, String) ->Void)) {
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 90
        provider.request(.checkDelivery(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = InstallmentBaseResponse.getObjFromDictionary(map: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func updateConstractStatus(params: [String: Any], completion: @escaping ((InstallmentBaseResponse?, String) ->Void)) {
        provider.request(.updateConstract(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = InstallmentBaseResponse.getObjFromDictionary(map: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    

    func getInstallmentHistory(params: [String: Any], completion: @escaping ((HistoryIsdetailBase?,InstallmentBaseResponse?, String) ->Void)) {
        let isdetail = params["isDetail"] as! Bool
        provider.request(.installmenthistory(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    if isdetail {
                        let rs = InstallmentBaseResponse.getObjFromDictionary(map: json)
                        completion(nil,rs,"")
                    } else {
                        let detailfalse = HistoryIsdetailBase.getObjFromDictionary(map: json)
                        completion(detailfalse,nil,"")
                    }
                    
                } catch let err {
                    completion(nil,nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil,nil, err.localizedDescription)
            }
        }
    }
    
    
}

enum InstallmentOnlineApiService {
    case customerOrders(params: [String: Any])
    case orderDerail(params: [String: Any])
    case updateImei(params: [String: Any])
    case checkDelivery(params: [String: Any])
    case updateConstract(params: [String: Any])
    case installmenthistory(params: [String: Any])
}

extension InstallmentOnlineApiService: TargetType {
    var path: String {
        switch self {
        case .customerOrders:
            return "/api/mirae/OnlineInstallmentOrders"
        case .orderDerail:
            return "/api/mirae/OnlineInstallmentOrderDetail"
        case .updateImei:
            return "/api/mirae/UpdateImei"
        case .checkDelivery:
            return "/api/mirae/CheckInfoForDelivery"
        case .updateConstract:
            return "/api/mirae/UpdateContractStatus"
        case .installmenthistory:
            return "/api/mirae/OnlineInstallmentHistory"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .customerOrders, .orderDerail, .updateImei, .checkDelivery, .updateConstract, .installmenthistory:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .customerOrders(let params), .orderDerail(let params), .updateImei(let params), .checkDelivery(let params), .updateConstract(let params), .installmenthistory(let params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .customerOrders, .orderDerail, .updateImei, .checkDelivery, .updateConstract, .installmenthistory:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
    var baseURL: URL {
        switch self {
        case .orderDerail, .updateImei, .checkDelivery, .updateConstract, .installmenthistory, .customerOrders:
            let urlStr = Config.manager.URL_GATEWAY + "/mpos-cloud-api"
            guard let url = URL(string: urlStr) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
}


