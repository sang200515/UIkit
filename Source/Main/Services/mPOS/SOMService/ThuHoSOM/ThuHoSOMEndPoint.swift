//
//  ThuHoSOMEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ThuHoSOMEndPoint {
    case getCategories(isEnable: Bool, parentId: String, shopCode: String, isDetail: Bool, sort: String)
    case getCustomer(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String)
    case makeOrder(param: ThuHoSOMOrderParam)
    case getOrderStatus(orderId: String, groupCode: String)
    case getOrderDetail(orderId: String)
    case getDefaultPayment(param: ThuHoSOMOrderParam)
    case addPayment(param: ThuHoSOMOrderParam)
    case removePayment(param: ThuHoSOMOrderParam)
    case getCards
    case getPaymentTypes
    case getBanks
    case getOrderHistory(term: String, fromDate: String, toDate: String)
    case getAgreements(providerId: String, contract: String, type: Int)
    case getProviders
    
    // BIKE INSURANCE
    case getBikeInsuranceProvider(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String)
    case getBikeInsuranceProduct(code: String)
    case getBikeInsuranceVoucher(productId: String, providerId: String, price: Int, phone: String, itemCode: String)
    case getEmployees
}

extension ThuHoSOMEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getCategories, .getCustomer, .getOrderStatus, .getOrderDetail, .getCards, .getPaymentTypes, .getBanks, .getAgreements, .getProviders, .getBikeInsuranceProvider, .getBikeInsuranceProduct, .getBikeInsuranceVoucher, .getEmployees:
            return .get
        default:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            
        switch self {
        case .getCategories:
            return BASE_URL + "/som-product-service/api/Product/v1/Categories"
        case .getCustomer:
            return BASE_URL + "/som-integration-service/api/integration/v1/customerv2"
        case .makeOrder:
            return BASE_URL + "/som-order-service/api/Order/v1/order"
        case .getOrderStatus:
            return BASE_URL + "/som-order-service/api/Order/v1/order/status"
        case .getOrderDetail:
            return BASE_URL + "/som-order-service/api/Order/v1/order"
        case .getDefaultPayment:
            return BASE_URL + "/som-order-service/api/Order/v1/order/calculate?action=0"
        case .addPayment:
            return BASE_URL + "/som-order-service/api/Order/v1/order/calculate?action=1"
        case .removePayment:
            return BASE_URL + "/som-order-service/api/Order/v1/order/calculate?action=2"
        case .getCards:
            return BASE_URL + "/som-product-service/api/Product/v1/Cards"
        case .getPaymentTypes:
            return BASE_URL + "/som-product-service/api/Product/v1/PaymentTypes"
        case .getBanks:
            return BASE_URL + "/som-product-service/api/Product/v1/Banks"
        case .getOrderHistory:
            return BASE_URL + "/som-search-service/api/Search/v1/Order"
        case .getAgreements:
            return BASE_URL + "/som-integration-service/api/integration/v1/ftel-findcontract"
        case .getProviders:
            return BASE_URL + "/som-product-service/api/Product/v1/Providers"

        case .getBikeInsuranceProvider:
            return BASE_URL + "/som-integration-service/api/integration/v1/customerv2"
        case .getBikeInsuranceProduct:
            return BASE_URL + "/som-product-service/api/Product/v1/Products/get-by-code"
        case .getBikeInsuranceVoucher:
            return BASE_URL + "/som-legacy-service/api/legacy/v1/GetOnFlyPaymentVoucher"
        case .getEmployees:
            return BASE_URL + "/som-legacy-service/api/legacy/v1/internal/\(Cache.user!.ShopCode)/get-employees"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getCategories(let isEnable, let parentId, let shopCode, let isDetail, let sort):
            return ["Enabled": String(isEnable),
                    "ParentId": parentId,
                    "warehouseCode": shopCode,
                    "_includeDetails": String(isDetail),
                    "_sort": sort]
        case .getCustomer(let providerId, let customerId, let groupCode, let productCode, let pin), .getBikeInsuranceProvider(let providerId, let customerId, let groupCode, let productCode, let pin):
            return ["ProviderId": providerId,
                    "CustomerId": customerId,
                    "integratedGroupCode": groupCode,
                    "integratedProductCode": productCode,
                    "pin": pin]
        case .makeOrder(let param), .getDefaultPayment(let param), .addPayment(let param), .removePayment(let param):
            return param.toJSON()
        case .getOrderStatus(let orderId, let groupCode):
            return ["orderId": orderId,
                    "integratedGroupCode": groupCode]
        case .getOrderDetail(let orderId):
            return ["id": orderId]
        case .getOrderHistory(let term, let fromDate, let toDate):
            let categoryIds: [String] = ["9d47824c-b08c-4327-a187-979a8cb8eb5c"]
            return ["term": term,
                    "warehouseCode": Cache.user!.ShopCode,
                    "fromDate": fromDate,
                    "toDate": toDate,
                    "isQueryMaKH": true,
                    "parentCategoryIds": categoryIds]
        case .getAgreements(let providerId, let contract, let type):
            return ["ProviderId": providerId,
                    "Contract": contract,
                    "Type": type,
                    "LocationID": 0]
        case .getProviders:
            return ["_skip": 0,
                    "_limit": 500]
        case .getBikeInsuranceProduct(let code):
            return ["code": code]
        case .getBikeInsuranceVoucher(let productId, let providerId, let price, let phone, let itemCode):
            return ["productId": productId,
                    "providerId": providerId,
                    "price": price,
                    "phone": phone,
                    "itemCode": itemCode]
        default:
            return [:]
        }
    }
}
