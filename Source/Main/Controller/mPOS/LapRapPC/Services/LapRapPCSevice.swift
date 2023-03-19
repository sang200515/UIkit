//
//  LapRapPCSevice.swift
//  fptshop
//
//  Created by Sang Truong on 10/8/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

protocol LapRapPCSeviceProtocol {
    func getListPC(shopCode:String,status:String,from:String,to:String,itemCode:String, success: @escaping SuccessHandler<LapRapPCItem>.object, failure: @escaping RequestFailure)
    func getListLinhKien(item_code_pc:String,doc_header:String,doc_request:String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure)
    func updateStatePCBuild(doc_request:String,doc_header:String,status:String,update_by_code:String,update_by_name:String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure)
    
    func insertBuildPC(doc_request: String,doc_header:String,update_by_code:String,update_by_name:String,detail:[[String: Any]], success: @escaping SuccessHandler<InsertPCItem>.object, failure: @escaping RequestFailure)
    func uploadImagePC(base64: String,folder:String,filename:String, success: @escaping SuccessHandler<DataUploadImagePC>.object, failure: @escaping RequestFailure)
    func uploadFilePC(userCode: String,shopCode:String,docEntry:String,fileName:String, success: @escaping SuccessHandler<DataUploadFilePC>.object, failure: @escaping RequestFailure)
}

class LapRapPCSevice: LapRapPCSeviceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getListPC(shopCode: String, status: String, from: String, to: String, itemCode: String, success: @escaping SuccessHandler<LapRapPCItem>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.getListPC(shopCode: shopCode, status: status, from: from, to: to, itemCode: itemCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListLinhKien(item_code_pc: String, doc_header: String, doc_request: String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.getListLinhKien(itemCode: item_code_pc, doc_request: doc_request, doc_header: doc_header)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateStatePCBuild(doc_request: String, doc_header: String, status: String, update_by_code: String, update_by_name: String, success: @escaping SuccessHandler<LinhKienItem>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.updateStateOrder(doc_request: doc_request, doc_header: doc_header, status: status, update_by_code: update_by_code, update_by_name: update_by_name)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func insertBuildPC(doc_request: String, doc_header: String, update_by_code: String, update_by_name: String, detail: [[String : Any]], success: @escaping SuccessHandler<InsertPCItem>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.insertOrderBuildPC(doc_request: doc_request, doc_header: doc_header, update_by_code: update_by_code, update_by_name: update_by_name, detail: detail)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func uploadImagePC(base64: String, folder: String, filename fileName: String, success: @escaping SuccessHandler<DataUploadImagePC>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.uploadImagePC(base64: base64, folder: folder, filename: fileName)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func uploadFilePC(userCode: String, shopCode: String, docEntry: String, fileName: String, success: @escaping SuccessHandler<DataUploadFilePC>.object, failure: @escaping RequestFailure) {
        let endPoint = LapRapPCEndPoint.saveImagePC(userCode: userCode, shopCode: shopCode, docEntry: docEntry, fileName: fileName)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}

