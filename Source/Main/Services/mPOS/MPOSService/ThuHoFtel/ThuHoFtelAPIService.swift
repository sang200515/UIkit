//
//  ThuHoFtelAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

protocol ThuHoFtelAPIServiceProtocol {
    func getListFtelOrder(fromDate: String, toDate: String, success: @escaping SuccessHandler<FtelReceipt>.array, failure: @escaping RequestFailure)
    func getFtelOrderDetail(orderId: String, success: @escaping SuccessHandler<FtelReciptDetail>.object, failure: @escaping RequestFailure)
    func getListFtelCard(success: @escaping SuccessHandler<FtelCard>.object, failure: @escaping RequestFailure)
    func getListFtelCardType(success: @escaping SuccessHandler<FtelCardType>.object, failure: @escaping RequestFailure)
    func ftelCardAction(param: FtelAddCardParam, isAdd: Bool, success: @escaping SuccessHandler<FtelReciptDetail>.object, failure: @escaping RequestFailure)
    func payFtelOrder(providerId: String, orderId: String, orderTransactionId: String, ftelTransactionId: String, total: Int, paymentRequestId: String, ftelOrderNumber: String, ftelContractNumber: String, success: @escaping SuccessHandler<FtelPayOrderResponse>.object, failure: @escaping RequestFailure)
}

class ThuHoFtelAPIService: ThuHoFtelAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getListFtelOrder(fromDate: String, toDate: String, success: @escaping SuccessHandler<FtelReceipt>.array, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.getListFtelOrder(fromDate: fromDate, toDate: toDate)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getFtelOrderDetail(orderId: String, success: @escaping SuccessHandler<FtelReciptDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.getFtelOrderDetail(orderID: orderId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListFtelCard(success: @escaping SuccessHandler<FtelCard>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.getListFtelCard
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListFtelCardType(success: @escaping SuccessHandler<FtelCardType>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.getListFtelCardType
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func ftelCardAction(param: FtelAddCardParam, isAdd: Bool, success: @escaping SuccessHandler<FtelReciptDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.ftelCardAction(param: param, isAdd: isAdd)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func payFtelOrder(providerId: String, orderId: String, orderTransactionId: String, ftelTransactionId: String, total: Int, paymentRequestId: String, ftelOrderNumber: String, ftelContractNumber: String, success: @escaping SuccessHandler<FtelPayOrderResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoFtelEndPoint.payFtelOrder(providerId: providerId, orderId: orderId, orderTransactionId: orderTransactionId, ftelTransactionId: ftelTransactionId, total: total, paymentRequestId: paymentRequestId, ftelOrderNumber: ftelOrderNumber, ftelContractNumber: ftelContractNumber)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
