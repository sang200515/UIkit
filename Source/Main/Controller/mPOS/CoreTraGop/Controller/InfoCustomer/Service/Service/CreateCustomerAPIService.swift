//
//  CreateCustomerAPIService.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import Foundation
protocol CreateCustomerProtocol {
    func createCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure)
    func editCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure)
    func loadInfoCustomer(id:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure)
    func searchInfoCustomer(keyword: String,skipCount:Int,maxResultCount:Int,success: @escaping SuccessHandler<DataSearchCustomer>.object, failure: @escaping RequestFailure)
//    func loadInfoCustomer(id:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure)
    func deleteInfoCustomer(id: String, success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure)
}

class CreateCustomerAPIService: CreateCustomerProtocol {



    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func createCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CreteCustomerEndpoint.createCustomerCoreInstallment(userCode: userCode, idCard: idCard, idCardType: idCardType, firstName: firstName, middleName: middleName, lastName: lastName, email: email, gender: gender, birthDate: birthDate, phone: phone, idCardIssuedBy: idCardIssuedBy, idCardIssuedDate: idCardIssuedDate, idCardIssuedExpiration: idCardIssuedExpiration, relatedDocument: relatedDocument, company: company, refPersons: refPersons, addresses: addresses, uploadFiles: uploadFiles,relatedDocType:relatedDocType)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func editCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String,success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CreteCustomerEndpoint.editCustomerCoreInstallment(userCode: userCode, idCard: idCard, idCardType: idCardType, firstName: firstName, middleName: middleName, lastName: lastName, email: email, gender: gender, birthDate: birthDate, phone: phone, idCardIssuedBy: idCardIssuedBy, idCardIssuedDate: idCardIssuedDate, idCardIssuedExpiration: idCardIssuedExpiration, relatedDocument: relatedDocument, company: company, refPersons: refPersons, addresses: addresses, uploadFiles: uploadFiles,relatedDocType:relatedDocType)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func loadInfoCustomer(id: String, success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CreteCustomerEndpoint.loadInfoCustomer(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func searchInfoCustomer(keyword: String, skipCount: Int, maxResultCount: Int, success: @escaping SuccessHandler<DataSearchCustomer>.object, failure: @escaping RequestFailure) {
        let endPoint = CreteCustomerEndpoint.searchInfoCustomer(keyword: keyword,skipCount:skipCount,maxResultCount:maxResultCount)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func deleteInfoCustomer(id: String, success: @escaping SuccessHandler<CreateCustomerModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CreteCustomerEndpoint.deleteInfoCustomer(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

}
