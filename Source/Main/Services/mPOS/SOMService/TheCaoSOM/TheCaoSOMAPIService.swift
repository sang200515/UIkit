//
//  TheCaoSOMAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol TheCaoSOMAPIServiceProtocol {
    func getCategories(parentID: String, success: @escaping SuccessHandler<TheNapSOMItems>.object, failure: @escaping RequestFailure)
    func getDefaultPayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func addPayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func removePayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func getCards(success: @escaping SuccessHandler<ThuHoSOMCards>.object, failure: @escaping RequestFailure)
    func getPaymentTypes(success: @escaping SuccessHandler<ThuHoSOMPaymentTypes>.object, failure: @escaping RequestFailure)
    func getProviders(success: @escaping SuccessHandler<ThuHoSOMProviders>.object, failure: @escaping RequestFailure)
    func makeOrder(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<ThuHoSOMOrder>.object, failure: @escaping RequestFailure)
    func getOrderStatus(orderId: String, groupCode: String, success: @escaping SuccessHandler<ThuHoSOMOrderStatus>.object, failure: @escaping RequestFailure)
    func getOrderDetail(orderId: String, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func getVoucher(code: String, cash: Int, card: Int, total: Int, price: Int, legacyID: String, categoryID: String, success: @escaping SuccessHandler<TheNapSOMVoucher>.object, failure: @escaping RequestFailure)
    func getCardDetails(providerID: String, orderID: String, transactionID: String, success: @escaping SuccessHandler<TheNapSOMCards>.object, failure: @escaping RequestFailure)
    func checkViettelCustomer(providerID: String, customerID: String, integratedGroupCode: String, integratedProductCode: String, success: @escaping (Bool) -> Void, failure: @escaping RequestFailure)
    func getViettelOffers(providerID: String, customerID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure)
    func sendViettelOTP(providerID: String, customerID: String, productType: String, productCode: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure)
    func getOrderHistory(term: String, fromDate: String, toDate: String, isTopup: Bool, success: @escaping SuccessHandler<ThuHoSOMHistory>.array, failure: @escaping RequestFailure)
    func checkStatus(phone: String, provider:String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure)
    func getVinaOffers(providerID: String, customerID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure)
    func sendVinaOTP(providerID: String, customerID: String, serviceCode: String, processID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure)
}

class TheCaoSOMAPIService: TheCaoSOMAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getCategories(parentID: String, success: @escaping SuccessHandler<TheNapSOMItems>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getCategories(parentID: parentID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getDefaultPayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getDefaultPayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func addPayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.addPayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func removePayment(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.removePayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCards(success: @escaping SuccessHandler<ThuHoSOMCards>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getCards
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getPaymentTypes(success: @escaping SuccessHandler<ThuHoSOMPaymentTypes>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getPaymentTypes
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getProviders(success: @escaping SuccessHandler<ThuHoSOMProviders>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getProviders
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func makeOrder(param: TheNapSOMOrderDetail, success: @escaping SuccessHandler<ThuHoSOMOrder>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.makeOrder(param: param)
        network.cancelAllRequest()
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderStatus(orderId: String, groupCode: String, success: @escaping SuccessHandler<ThuHoSOMOrderStatus>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getOrderStatus(orderId: orderId, groupCode: groupCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderDetail(orderId: String, success: @escaping SuccessHandler<TheNapSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getOrderDetail(orderId: orderId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getVoucher(code: String, cash: Int, card: Int, total: Int, price: Int, legacyID: String, categoryID: String, success: @escaping SuccessHandler<TheNapSOMVoucher>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getVoucher(code: code, cash: cash, card: card, total: total, price: price, legacyID: legacyID, categoryID: categoryID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCardDetails(providerID: String, orderID: String, transactionID: String, success: @escaping SuccessHandler<TheNapSOMCards>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getCardDetails(providerID: providerID, orderID: orderID, transactionID: transactionID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func checkViettelCustomer(providerID: String, customerID: String, integratedGroupCode: String, integratedProductCode: String, success: @escaping (Bool) -> Void, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.checkViettelCustomer(providerID: providerID, customerID: customerID, integratedGroupCode: integratedGroupCode, integratedProductCode: integratedProductCode)
        network.requestDataBool(endPoint: endPoint, success: { data in
            success(data as! Bool)
        }, failure: failure)
    }
    
    func getViettelOffers(providerID: String, customerID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getViettelOffers(providerID: providerID, customerID: customerID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func sendViettelOTP(providerID: String, customerID: String, productType: String, productCode: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.sendViettelOTP(providerID: providerID, customerID: customerID, productType: productType, productCode: productCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderHistory(term: String, fromDate: String, toDate: String, isTopup: Bool, success: @escaping SuccessHandler<ThuHoSOMHistory>.array, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getOrderHistory(term: term, fromDate: fromDate, toDate: toDate, isTopup: isTopup)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func checkStatus(phone: String, provider: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.checkStatus(cusPhoneNumber: phone, providerID: provider)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getVinaOffers(providerID: String, customerID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.getVinaOffers(providerID: providerID, customerID: customerID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func sendVinaOTP(providerID: String, customerID: String, serviceCode: String, processID: String, success: @escaping SuccessHandler<BanTienSOMViettelOffers>.object, failure: @escaping RequestFailure) {
        let endPoint = TheCaoSOMEndPoint.sendVinaOTP(providerID: providerID, customerID: customerID, serviceCode: serviceCode, processID: processID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
