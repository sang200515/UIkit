//
//  RaPCSevice.swift
//  fptshop
//
//  Created by Sang Truong on 12/1/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

protocol RaPCSeviceProtocol {
    func getListPC(shopCode:String,status:String,from:String,to:String,itemCode:String,requestType:String, success: @escaping SuccessHandler<RaPCItem>.object, failure: @escaping RequestFailure)
    func getListLinhKien(item_code_pc:String,doc_header:String,doc_request:String, success: @escaping SuccessHandler<DetailsLinhKien>.object, failure: @escaping RequestFailure)
    func getDetailsImei(item_code_pc:String,imei:String, success: @escaping SuccessHandler<ListLKByImei>.object, failure: @escaping RequestFailure)

    func updateStatePCBuild(doc_request:String,doc_header:String,status:String,update_by_code:String,update_by_name:String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure)
    
    func insertBuildPC(doc_request: String,doc_header:String,update_by_code:String,update_by_name:String,detail:[[String: Any]], success: @escaping SuccessHandler<InsertPCItem>.object, failure: @escaping RequestFailure)
}

class RaPCSevice: RaPCSeviceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getListPC(shopCode: String, status: String, from: String, to: String, itemCode: String,requestType:String, success: @escaping SuccessHandler<RaPCItem>.object, failure: @escaping RequestFailure) {
        let endPoint = RaPCEndPoint.getListPC(shopCode: shopCode, status: status, from: from, to: to, itemCode: itemCode,requestType:requestType)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListLinhKien(item_code_pc: String, doc_header: String, doc_request: String, success: @escaping SuccessHandler<DetailsLinhKien>.object, failure: @escaping RequestFailure) {
        let endPoint = RaPCEndPoint.getListLinhKien(itemCode: item_code_pc, doc_request: doc_request, doc_header: doc_header)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getDetailsImei(item_code_pc: String, imei: String, success: @escaping SuccessHandler<ListLKByImei>.object, failure: @escaping RequestFailure) {
        let endPoint = RaPCEndPoint.getDetailsImei(itemCode: item_code_pc, imei: imei)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func updateStatePCBuild(doc_request: String, doc_header: String, status: String, update_by_code: String, update_by_name: String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure) {
        let endPoint = RaPCEndPoint.updateStateOrder(doc_request: doc_request, doc_header: doc_header, status: status, update_by_code: update_by_code, update_by_name: update_by_name)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func insertBuildPC(doc_request: String, doc_header: String, update_by_code: String, update_by_name: String, detail: [[String : Any]], success: @escaping SuccessHandler<InsertPCItem>.object, failure: @escaping RequestFailure) {
        let endPoint = RaPCEndPoint.insertOrderBuildPC(doc_request: doc_request, doc_header: doc_header, update_by_code: update_by_code, update_by_name: update_by_name, detail: detail)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
