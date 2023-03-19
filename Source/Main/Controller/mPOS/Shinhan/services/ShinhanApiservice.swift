//
//  ShinhanApiservice.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ShinhanServiceProtocol {
    func detechCmndFont(base64: String, success: @escaping SuccessHandler<ShinhanFontBase>.object, failure: @escaping RequestFailure)
    func detechCmndBehind(base64: String, success: @escaping SuccessHandler<ShinhanBehindBase>.object, failure: @escaping RequestFailure)
    func loadInfoCustomer(docEntry: Int,loadType: Int,id: String, success: @escaping SuccessHandler<ShinhanBeforeCreateBase>.object, failure: @escaping RequestFailure)
    func loadCity(success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure)
    func loadRelationship(success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure)
    func loadDistricts(cityCode: String, success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure)
    func loadPayemntDate(success: @escaping SuccessHandler<ShinhanPaymentDateBase>.object, failure: @escaping RequestFailure)
    func loadWawrds(districtCode: String, success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure)
    func saveApplication(personalLoan: [String: Any],permanentAddress: [String: Any],residenceAddress: [String: Any],refPerson1: [String: Any],person2: [String: Any],workinfor: [String: Any], success: @escaping SuccessHandler<ShinhanSaveAppBase>.object, failure: @escaping RequestFailure)
    func loadGoitragop(rdr1: String,success: @escaping SuccessHandler<ShinhanGoitragopBase>.object, failure: @escaping RequestFailure)
    func uploadimage(docID: String, idCard: String,trackingID: String,base64: String,success: @escaping SuccessHandler<ShinhanUploadBase>.object, failure: @escaping RequestFailure)
    func submitApplication(promos: String,rdr1: String,neeSubmit: Bool,submitValue: Bool,success: @escaping SuccessHandler<ShinhanSubmitBase>.object, failure: @escaping RequestFailure)
    func loadListHistoryOrder(type : String,success: @escaping SuccessHandler<ShinhanOrderHistory>.object, failure: @escaping RequestFailure)
    func loadDetailOrder(docEntry: String,success: @escaping SuccessHandler<ShinhanDetailBase>.object, failure: @escaping RequestFailure)
    func reuploadImage(trackingID: String,type: Int,success: @escaping SuccessHandler<ShinhanUploadBase>.object, failure: @escaping RequestFailure)
    func loadSchemeList(mposNum: String,docEntry: String,success: @escaping SuccessHandler<ShinhanSchemeBase>.object, failure: @escaping RequestFailure)
    
    
}

class ShinhanService: ShinhanServiceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func detechCmndFont(base64: String, success: @escaping SuccessHandler<ShinhanFontBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.detechCmnd(base64: base64, isFont: true)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func detechCmndBehind(base64: String, success: @escaping SuccessHandler<ShinhanBehindBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.detechCmnd(base64: base64, isFont: false)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadInfoCustomer(docEntry: Int, loadType: Int, id: String, success: @escaping SuccessHandler<ShinhanBeforeCreateBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadInforCustomer(docentry: docEntry, loadType: loadType, idCard: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadCity(success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadCity
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadRelationship(success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadRelationShip
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadDistricts(cityCode: String, success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadDistricts(cityCode: cityCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadWawrds(districtCode: String, success: @escaping SuccessHandler<ShinhanDistrictBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadWards(districtCode: districtCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func saveApplication(personalLoan: [String : Any], permanentAddress: [String : Any], residenceAddress: [String : Any], refPerson1: [String : Any], person2: [String : Any], workinfor: [String : Any], success: @escaping SuccessHandler<ShinhanSaveAppBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.saveApplication(personalLoan: personalLoan, pernamentAddress: permanentAddress, residentAddress: residenceAddress, person1: refPerson1, person2: person2, workInfo: workinfor)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadPayemntDate(success: @escaping SuccessHandler<ShinhanPaymentDateBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadPaymentDate
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadGoitragop(rdr1: String, success: @escaping SuccessHandler<ShinhanGoitragopBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadGoiTraGop(rdr1: rdr1)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func uploadimage(docID: String, idCard: String, trackingID: String, base64: String, success: @escaping SuccessHandler<ShinhanUploadBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.uploadImage(documentId: docID, idCard: idCard, trackingID: trackingID, base64: base64)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func submitApplication(promos: String, rdr1: String,neeSubmit: Bool,submitValue: Bool, success: @escaping SuccessHandler<ShinhanSubmitBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.saveSubmitApplication(prosmos: promos, rdr1: rdr1,neeSubmit: neeSubmit,submitValue: submitValue)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadListHistoryOrder(type: String, success: @escaping SuccessHandler<ShinhanOrderHistory>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadListOrders(type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loadDetailOrder(docEntry: String, success: @escaping SuccessHandler<ShinhanDetailBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadDetailOrder(docEntry: docEntry)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func reuploadImage(trackingID: String,type: Int, success: @escaping SuccessHandler<ShinhanUploadBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.reUploadImage(trackingID: trackingID, type: type)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func loadSchemeList(mposNum: String, docEntry: String, success: @escaping SuccessHandler<ShinhanSchemeBase>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinhanEnpoint.loadBookedOrder(posNum: mposNum, docEntry: docEntry)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
