//
//  TheCaoSOMEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum TheCaoSOMEndPoint {
    case getCategories(parentID: String)
    case getDefaultPayment(param: TheNapSOMOrderDetail)
    case addPayment(param: TheNapSOMOrderDetail)
    case removePayment(param: TheNapSOMOrderDetail)
    case getCards
    case getPaymentTypes
    case getProviders
    case makeOrder(param: TheNapSOMOrderDetail)
    case getOrderStatus(orderId: String, groupCode: String)
    case getOrderDetail(orderId: String)
    case getVoucher(code: String, cash: Int, card: Int, total: Int, price: Int, legacyID: String, categoryID: String)
    case getCardDetails(providerID: String, orderID: String, transactionID: String)
    case checkViettelCustomer(providerID: String, customerID: String, integratedGroupCode: String, integratedProductCode: String)
    case getViettelOffers(providerID: String, customerID: String)
    case sendViettelOTP(providerID: String, customerID: String, productType: String, productCode: String)
    case getOrderHistory(term: String, fromDate: String, toDate: String, isTopup: Bool)
    case checkStatus(cusPhoneNumber: String,providerID:String)
    case getVinaOffers(providerID: String, customerID: String)
    case sendVinaOTP(providerID: String, customerID: String, serviceCode: String, processID: String)
}

extension TheCaoSOMEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getCategories, .getCards, .getPaymentTypes, .getProviders, .getOrderStatus, .getOrderDetail, .getVoucher, .getCardDetails, .checkViettelCustomer:
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
        case .getProviders:
            return BASE_URL + "/som-product-service/api/Product/v1/Providers"
        case .makeOrder:
            return BASE_URL + "/som-order-service/api/Order/v1/order"
        case .getOrderStatus:
            return BASE_URL + "/som-order-service/api/Order/v1/order/status"
        case .getOrderDetail:
            return BASE_URL + "/som-order-service/api/Order/v1/order"
        case .getVoucher:
            return BASE_URL + "/som-legacy-service/api/legacy/v1/PaymentVoucher"
        case .getCardDetails:
            return BASE_URL + "/som-integration-service/api/integration/v1/cards"
        case .checkViettelCustomer:
            return BASE_URL + "/som-integration-service/api/integration/v1/customer"
        case .getViettelOffers:
            return BASE_URL + "/som-integration-service/api/integration/v1/viettel/tvbh-vas/get-offers"
        case .sendViettelOTP:
            return BASE_URL + "/som-integration-service/api/integration/v1/viettel/tvbh-vas/send-otp"
        case .getOrderHistory:
            return BASE_URL + "/som-search-service/api/Search/v1/Order"
        case .checkStatus:
            return BASE_URL + "/som-integration-service/api/integration/v1/MobifoneVas/check-status"
        case .getVinaOffers:
            return BASE_URL + "/som-integration-service/api/integration/v1/vinaphone/vas/get-offers"
        case .sendVinaOTP:
            return BASE_URL + "/som-integration-service/api/integration/v1/vinaphone/vas/send-otp"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getCategories(let parentID):
            return ["Enabled": "true",
                    "ParentId": parentID,
                    "warehouseCode": Cache.user!.ShopCode,
                    "_includeDetails": "true",
                    "_sort": "orderno"]
        case .getDefaultPayment(let param), .addPayment(let param), .removePayment(let param), .makeOrder(let param):
            return param.toJSON()
        case .getOrderStatus(let orderId, let groupCode):
            return ["orderId": orderId,
                    "integratedGroupCode": groupCode]
        case .getOrderDetail(let orderId):
            return ["id": orderId]
        case .getProviders:
            return ["_skip": 0,
                    "_limit": 500]
        case .getVoucher(let code, let cash, let card, let total, let price, let legacyID, let categoryID):
            return ["voucherCode": code,
                    "isPaymentService": 1,
                    "serviceType": "",
                    "transferAmount": 0,
                    "cardAmount": card,
                    "cashAmount": cash,
                    "totalAmount": total,
                    "price": price,
                    "legacyId": legacyID,
                    "categoryId": categoryID]
        case .getCardDetails(let providerID, let orderID, let transactionID):
            return ["ProviderId": providerID,
                    "OrderId": orderID,
                    "OrderTransactionId": transactionID]
        case .checkViettelCustomer(let providerID, let customerID, let integratedGroupCode, let integratedProductCode):
            return ["ProviderId": providerID,
                    "CustomerId": customerID,
                    "integratedGroupCode": integratedGroupCode,
                    "integratedProductCode": integratedProductCode,
                    "pin": ""]
        case .getViettelOffers(let providerID, let customerID):
            return ["providerId": providerID,
                    "customer": customerID]
        case .sendViettelOTP(let providerID, let customerID, let productType, let productCode):
            return ["providerId": providerID,
                    "customer": customerID,
                    "productType": productType,
                    "productCode": productCode]
        case .getOrderHistory(let term, let fromDate, let toDate, let isTopup):
            let categoryIds: [String] = isTopup ? ["ddabdaa8-c0de-4e48-88fb-0bf4b16312ac",
                                                   "d83158d9-fd96-4090-9f4c-fe98dd59cc94",
                                                   "3eb6ca88-e544-409b-98a6-e3f438b083cc",
                                                   "9de91c80-4b2a-43da-bf33-cf054ef36a2d"] : ["ddabdaa8-c0de-4e48-88fb-0bf4b16312ac"]
            return ["term": term,
                    "warehouseCode": Cache.user!.ShopCode,
                    "fromDate": fromDate,
                    "toDate": toDate,
                    "isQueryMaKH": false,
                    "parentCategoryIds": categoryIds]
        case .checkStatus(let cusPhoneNumber,let providerID):
            return ["customerPhoneNumber": cusPhoneNumber,
                    "providerId": providerID]
        case .getVinaOffers(let providerID, let customerID):
            return ["providerId": providerID,
                    "msisdn": customerID]
        case .sendVinaOTP(let providerID, let customerID, let serviceCode, let processID):
            return ["providerId": providerID,
                    "msisdn": customerID,
                    "serviceCode": serviceCode,
                    "processId": processID]
        default:
            return [:]
        }
    }
}
