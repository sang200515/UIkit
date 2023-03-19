//
//  ProductAPIService.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

import Alamofire
enum SOMAPIService {
    case getInfoProviderSOM(params:[String:Any])
    case getInfoCustomerSOM(params:[String:Any])
    case createOrderSOM(params:[String:Any])
    case checkStatusSOM(params:[String:Any])
    case getOrderSOM(params:[String:Any])
    case filterItemsHistorySOM(params:[String:Any])
    // MARK: - MoMo
    case checkPemissionMoMo(params:[String:Any])
    case getOrderVoucher(orderID: String, params:[String:Any])
    case getProviderDetail(providerID: String, params:[String:Any])
    case checkPermissionWallet(params:[String:Any])
}

extension SOMAPIService: TargetType {
    private static var _defaults = UserDefaults.standard
    
    var baseURL: URL {
        switch self {
        case .checkPemissionMoMo:
            return URL(string: "\(Config.manager.URL_GATEWAY!)")!
        case .getInfoProviderSOM, .getInfoCustomerSOM, .createOrderSOM, .checkStatusSOM, .getOrderSOM, .filterItemsHistorySOM, .getOrderVoucher, .getProviderDetail, .checkPermissionWallet:
            return URL(string: "\(Config.manager.URL_GATEWAY!)")!
        }
    }
    var path: String {
        switch self {
            
        case .checkPemissionMoMo(_):
            return "/mpos-cloud-api/api/momo/checkPemission"
        case .getInfoProviderSOM(_):
            return "/som-product-service/api/Product/v1/Products/cd989f38-9cbb-4796-a27d-796d6ad28a72"
        case .getInfoCustomerSOM(_):
            return "/som-integration-service/api/integration/v1/info"
        case .createOrderSOM(_):
            return "/som-order-service/api/Order/v1/order"
        case .checkStatusSOM(_):
            return "som-order-service/api/Order/v1/order/status"
        case .getOrderSOM(_):
            return "/som-order-service/api/Order/v1/order"
        case .filterItemsHistorySOM(_):
            return "/som-search-service/api/Search/v1/Order/Filter"
        case .getOrderVoucher(let orderID, _):
            return "/som-legacy-service/api/legacy/v1/voucher/\(orderID)"
        case .getProviderDetail(let providerID, _):
            return "/som-product-service/api/Product/v1/Providers/\(providerID)"
        case .checkPermissionWallet:
            return "/promotion-service/api/v1/Promotion/Calc_wallet"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getInfoProviderSOM, .checkStatusSOM, .getOrderSOM, .filterItemsHistorySOM, .getOrderVoucher, .getProviderDetail:
            return .get
        case .checkPemissionMoMo, .getInfoCustomerSOM, .createOrderSOM, .checkPermissionWallet:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .checkPemissionMoMo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .getInfoProviderSOM(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .getInfoCustomerSOM(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .createOrderSOM(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .checkStatusSOM(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .getOrderSOM(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .filterItemsHistorySOM(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .getOrderVoucher(_, params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .getProviderDetail(_, params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .checkPermissionWallet(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        var access_token = SOMAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        
        return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        
        
        
        
    }

    var sampleData: Data {
        return Data()
    }
    
    
    
    
}
