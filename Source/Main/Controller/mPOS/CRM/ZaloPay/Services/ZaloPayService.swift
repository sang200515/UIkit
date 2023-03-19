//
//  ZaloPayService.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
enum ZaloPayService {
    case searchOrders(parameters: [String: Any])
    case detailOrder(parameters: [String: Any])
    case userByQR(parameters: [String: Any])
    case getInfoProduct(id: String)
    case getInfoProvider(id: String)
    case createOrder(parameters: [String: Any])
    case userByPhone(parameters: [String: Any])
    case printBill(shopCode: String,parameters: [String: Any])
    case checkStatusOrder(parameters: [String: Any])
    case getVoucher(id: String,parameters: [String: Any])
    case getCategories(parameters: [String: Any])
}
extension ZaloPayService: TargetType {
    private static var _defaults = UserDefaults.standard
    private static var _manager = Config.manager
    
    var baseURL: URL {
        switch self {
        case .searchOrders,.detailOrder,.userByQR,.getInfoProduct,.getInfoProvider,.createOrder,.userByPhone,.checkStatusOrder,.getVoucher,.getCategories:
            return URL(string: "\(ZaloPayService._manager.URL_GATEWAY!)")!
        case .printBill:
            return URL(string: "\(ZaloPayService._manager.URL_PRINT_BILL!)")!
        }
    }
    var path: String {
        switch self {
        case .searchOrders:
            return "/som-search-service/api/Search/v1/Order"
        case .detailOrder:
            return "/som-order-service/api/Order/v1/order"
        case .userByQR:
            return "/som-integration-service/api/integration/v1/ZaloPay/userbyqr"
        case .getInfoProduct(let id):
            return "/som-product-service/api/Product/v1/Products/\(id)"
        case .getInfoProvider(let id):
            return "/som-product-service/api/Product/v1/Providers/\(id)"
        case .createOrder:
            return "/som-order-service/api/Order/v1/order"
        case .userByPhone:
            return "/som-integration-service/api/integration/v1/ZaloPay/user"
        case .printBill(let shopCode,_):
            return "/api/\(shopCode)/push"
        case .checkStatusOrder:
            return "/som-order-service/api/Order/v1/order/status"
        case .getVoucher(let shopCode,_):
            return "/som-legacy-service/api/legacy/v1/voucher/\(shopCode)"
        case .getCategories:
            return "/som-product-service/api/Product/v1/Categories"
        }
    }
    var method: Moya.Method {
        switch self {
        case .searchOrders,.userByQR,.createOrder,.userByPhone,.printBill:
            return .post
        case .detailOrder,.getInfoProduct,.getInfoProvider,.checkStatusOrder,.getVoucher,.getCategories:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case let .searchOrders(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .detailOrder(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .userByQR(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getInfoProduct(_):
            return .requestPlain
        case .getInfoProvider(_):
            return .requestPlain
        case let .createOrder(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .userByPhone(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .printBill(_,parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .checkStatusOrder(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .getVoucher(_,parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .getCategories(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        var access_token = ZaloPayService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        switch self {
        case .searchOrders,.detailOrder,.userByQR,.getInfoProduct,.createOrder,.userByPhone,.printBill,.checkStatusOrder,.getVoucher:
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        default:
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        }
    }
    var sampleData: Data {
        return Data()
    }
}
