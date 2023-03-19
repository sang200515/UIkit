//
//  ThuHoFtelEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Alamofire

enum ThuHoFtelEndPoint {
    case getListFtelOrder(fromDate: String, toDate: String)
    case getFtelOrderDetail(orderID: String)
    case getListFtelCard
    case getListFtelCardType
    case ftelCardAction(param: FtelAddCardParam, isAdd: Bool)
    case payFtelOrder(providerId: String, orderId: String, orderTransactionId: String, ftelTransactionId: String, total: Int, paymentRequestId: String, ftelOrderNumber: String, ftelContractNumber: String)
}

extension ThuHoFtelEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getFtelOrderDetail,
             .getListFtelCard,
             .getListFtelCardType:
            return .get
        default:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        switch self {
        case .getListFtelOrder:
            return BASE_URL + "/som-search-service/api/Search/v1/Order"
        case .getFtelOrderDetail(let orderId):
            return BASE_URL + "/som-order-service/api/Order/v1/order?id=\(orderId)"
        case .getListFtelCard:
            return BASE_URL + "/som-product-service/api/Product/v1/PaymentTypes"
        case .getListFtelCardType:
            return BASE_URL + "/som-product-service/api/Product/v1/Cards"
        case .ftelCardAction( _, let isAdd):
            return BASE_URL + "/som-order-service/api/Order/v1/order/recalculate?action=" + (isAdd ? "1" : "2")
        case .payFtelOrder:
            return BASE_URL + "/som-integration-service/api/integration/v1/ftel/mobile-sale/pay-order"
        }
    }

    var parameters: JSONDictionary {
        switch self {
        case .getListFtelOrder(let fromDate, let toDate):
            return  ["warehouseCode": Cache.user?.ShopCode ?? "",
                     "fromDate": fromDate,
                     "toDate": toDate,
                     "parentCategoryIds": [],
                     "categoryId": "d9f0bc60-285a-41ec-bb58-85bbfae0c194"]
        case .ftelCardAction(let param, _):
            return param.toJSON()
        case .payFtelOrder(let providerId, let orderId, let orderTransactionId, let ftelTransactionId, let total, let paymentRequestId, let ftelOrderNumber, let ftelContractNumber):
        return ["providerId": providerId,
                "orderId": orderId,
                "orderTransactionId": orderTransactionId,
                "ftelTransactionId": ftelTransactionId,
                "total": total,
                "paymentRequestId": paymentRequestId,
                "ftelOrderNumber": ftelOrderNumber,
                "ftelContractNumber": ftelContractNumber]
        default:
            return [:]
        }
    }
}
