//
//  EcomOrdersApiService.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol EcomOrdersServiceProtocol {
    func loadListOrders(user: String,shopCode:String,type: String, success: @escaping SuccessHandler<Ecom_Order_Item>.array, failure: @escaping RequestFailure)
    func writeLog(user: String,shopCode:String,ecomNum: Int, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure)
    func loadEmployees(user: String, shopCode: String, success: @escaping SuccessHandler<EcomOrderEmploy>.array, failure: @escaping RequestFailure)
    func phancongNV(user:String,shopCode: String,ecomNum: Int,sale: String,typeAssignment:String, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure)
    func getEmployByEcom(ecomNum: Int, success: @escaping SuccessHandler<EcomOrderEmploy>.array, failure: @escaping RequestFailure)
    func confirmSale(ecomNum: Int,status: Int,comment:String,timeDelivery:String,addressDelivery:String,tinh:String,huyen:String,xa:String, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure)
    func setSodelivering(docNum: String,user: String,pass: String, success: @escaping SuccessHandler<DeliveringSuccessItem>.object, failure: @escaping RequestFailure)
    func getEcomOrderDetails(docNum: String, success: @escaping SuccessHandler<EcomOrderDetailsModel>.object, failure: @escaping RequestFailure)
    func getEcomOderTinh(success: @escaping SuccessHandler<EcomOrderTinhModel>.array, failure: @escaping RequestFailure)
    func getEcomOderQuanHuyen(tinhThanhPhoID:String, success: @escaping SuccessHandler<EcomOrderQuanHuyenModel>.array, failure: @escaping RequestFailure)
    func getEcomOderPhuongXa(quanHuyenID:String, success: @escaping SuccessHandler<EcomOrderPhuongXaModel>.array, failure: @escaping RequestFailure)
}

class EcomOrdersService: EcomOrdersServiceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
   
    func loadListOrders(user: String, shopCode: String, type: String, success: @escaping SuccessHandler<Ecom_Order_Item>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.loadListEcomOrders(user: user, shopcode: shopCode, type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func writeLog(user: String, shopCode: String, ecomNum: Int, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.wirteLog(user: user, shopCode: shopCode, ecomNum: ecomNum)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadEmployees(user: String, shopCode: String, success: @escaping SuccessHandler<EcomOrderEmploy>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.loadListEmployees(user: user, shopCode: shopCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func phancongNV(user: String, shopCode: String, ecomNum: Int, sale: String,typeAssignment:String, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.phanconNV(user: user, shopCode: shopCode, ecomNum: ecomNum, sale: sale,typeAssignment:typeAssignment)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getEmployByEcom(ecomNum: Int, success: @escaping SuccessHandler<EcomOrderEmploy>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.getEmployByEcom(ecomNum: ecomNum)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func confirmSale(ecomNum: Int, status: Int, comment: String, timeDelivery:String, addressDelivery:String,tinh:String,huyen:String,xa:String, success: @escaping SuccessHandler<EcomOrderBaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.confirmSale(ecomNum: ecomNum, status: status, comment: comment, timeDelivery:timeDelivery,addressdelivery:addressDelivery,tinh:tinh,huyen:huyen,xa:xa)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func setSodelivering(docNum: String, user: String, pass: String, success: @escaping SuccessHandler<DeliveringSuccessItem>.object, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.setSoDelivering(docNum: docNum, user: user, pass: pass)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getEcomOrderDetails(docNum: String, success: @escaping SuccessHandler<EcomOrderDetailsModel>.object, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.getEcomOrderDetails(docNum: docNum)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getEcomOderTinh(success: @escaping SuccessHandler<EcomOrderTinhModel>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.getEcomOderTinh
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getEcomOderQuanHuyen(tinhThanhPhoID:String,success: @escaping SuccessHandler<EcomOrderQuanHuyenModel>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.getEcomOderQuanHuyen(tinhThanhPhoID: tinhThanhPhoID)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getEcomOderPhuongXa(quanHuyenID:String, success: @escaping SuccessHandler<EcomOrderPhuongXaModel>.array, failure: @escaping RequestFailure) {
        let endPoint = EcomOrdersEndPoint.getEcomOderPhuongXa(quanHuyenID: quanHuyenID)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
