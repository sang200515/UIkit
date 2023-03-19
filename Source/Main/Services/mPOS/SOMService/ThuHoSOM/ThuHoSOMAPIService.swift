//
//  ThuHoSOMAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ThuHoSOMAPIServiceProtocol {
    func getCategories(isEnable: Bool, parentId: String, shopCode: String, isDetail: Bool, sort: String, success: @escaping SuccessHandler<ThuHoSOMCatagories>.object, failure: @escaping RequestFailure)
    func getCustomer(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String, success: @escaping SuccessHandler<ThuHoSOMCustomer>.object, failure: @escaping RequestFailure)
    func makeOrder(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrder>.object, failure: @escaping RequestFailure)
    func getOrderStatus(orderId: String, groupCode: String, success: @escaping SuccessHandler<ThuHoSOMOrderStatus>.object, failure: @escaping RequestFailure)
    func getOrderDetail(orderId: String, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func getDefaultPayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func addPayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func removePayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure)
    func getCards(success: @escaping SuccessHandler<ThuHoSOMCards>.object, failure: @escaping RequestFailure)
    func getPaymentTypes(success: @escaping SuccessHandler<ThuHoSOMPaymentTypes>.object, failure: @escaping RequestFailure)
    func getBanks(success: @escaping SuccessHandler<ThuHoSOMBanks>.object, failure: @escaping RequestFailure)
    func getOrderHistory(term: String, fromDate: String, toDate: String, success: @escaping SuccessHandler<ThuHoSOMHistory>.array, failure: @escaping RequestFailure)
    func getAgreements(providerId: String, contract: String, type: Int, success: @escaping SuccessHandler<ThuHoSOMAgreements>.object, failure: @escaping RequestFailure)
    func getProviders(success: @escaping SuccessHandler<ThuHoSOMProviders>.object, failure: @escaping RequestFailure)
    func pushBillThuHoSOM(printBill: ThuHoSOMPrintBill)
    
    // BIKE INSURANCE
    func getBikeInsuranceProvider(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String, success: @escaping SuccessHandler<ThuHoSOMBikeInsurance>.object, failure: @escaping RequestFailure)
    func getBikeInsuranceProduct(code: String, success: @escaping SuccessHandler<ThuHoSOMBikeInsuranceProductByCode>.object, failure: @escaping RequestFailure)
    func getBikeInsuranceVoucher(productId: String, providerId: String, price: Int, phone: String, itemCode: String, success: @escaping SuccessHandler<TheNapSOMVoucher>.object, failure: @escaping RequestFailure)
    func getEmployees(success: @escaping SuccessHandler<ThuHoSOMBikeInsuranceEmployee>.array, failure: @escaping RequestFailure)
}

class ThuHoSOMAPIService: ThuHoSOMAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getCategories(isEnable: Bool, parentId: String, shopCode: String, isDetail: Bool, sort: String, success: @escaping SuccessHandler<ThuHoSOMCatagories>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getCategories(isEnable: isEnable, parentId: parentId, shopCode: shopCode, isDetail: isDetail, sort: sort)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCustomer(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String, success: @escaping SuccessHandler<ThuHoSOMCustomer>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getCustomer(providerId: providerId, customerId: customerId, groupCode: groupCode, productCode: productCode, pin: pin)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func makeOrder(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrder>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.makeOrder(param: param)
        network.cancelAllRequest()
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderStatus(orderId: String, groupCode: String, success: @escaping SuccessHandler<ThuHoSOMOrderStatus>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getOrderStatus(orderId: orderId, groupCode: groupCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderDetail(orderId: String, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getOrderDetail(orderId: orderId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getDefaultPayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getDefaultPayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func addPayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.addPayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func removePayment(param: ThuHoSOMOrderParam, success: @escaping SuccessHandler<ThuHoSOMOrderDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.removePayment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCards(success: @escaping SuccessHandler<ThuHoSOMCards>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getCards
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getPaymentTypes(success: @escaping SuccessHandler<ThuHoSOMPaymentTypes>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getPaymentTypes
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBanks(success: @escaping SuccessHandler<ThuHoSOMBanks>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getBanks
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderHistory(term: String, fromDate: String, toDate: String, success: @escaping SuccessHandler<ThuHoSOMHistory>.array, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getOrderHistory(term: term, fromDate: fromDate, toDate: toDate)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getAgreements(providerId: String, contract: String, type: Int, success: @escaping SuccessHandler<ThuHoSOMAgreements>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getAgreements(providerId: providerId, contract: contract, type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getProviders(success: @escaping SuccessHandler<ThuHoSOMProviders>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getProviders
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func pushBillThuHoSOM(printBill: ThuHoSOMPrintBill) {
        let mn = Config.manager
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        
        if let data = try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []) {
            if let jsonData = String(data: data, encoding: .utf8) {
                print(jsonData)
                let billParam = BillParam(title: "Test PrintShare thu hộ", body: jsonData, id: "POS", key: "pos_thuho_v2")
                let billMessage = BillMessage(message:billParam)
                
                if let data2 = try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []) {
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    
    func getBikeInsuranceProvider(providerId: String, customerId: String, groupCode: String, productCode: String, pin: String, success: @escaping SuccessHandler<ThuHoSOMBikeInsurance>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getBikeInsuranceProvider(providerId: providerId, customerId: customerId, groupCode: groupCode, productCode: productCode, pin: pin)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBikeInsuranceProduct(code: String, success: @escaping SuccessHandler<ThuHoSOMBikeInsuranceProductByCode>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getBikeInsuranceProduct(code: code)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBikeInsuranceVoucher(productId: String, providerId: String, price: Int, phone: String, itemCode: String, success: @escaping SuccessHandler<TheNapSOMVoucher>.object, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getBikeInsuranceVoucher(productId: productId, providerId: providerId, price: price, phone: phone, itemCode: itemCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getEmployees(success: @escaping SuccessHandler<ThuHoSOMBikeInsuranceEmployee>.array, failure: @escaping RequestFailure) {
        let endPoint = ThuHoSOMEndPoint.getEmployees
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
