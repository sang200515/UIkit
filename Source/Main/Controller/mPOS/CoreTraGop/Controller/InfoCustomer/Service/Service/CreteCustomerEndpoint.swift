//
//  CreteCustomerEndpoint.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import Alamofire
import Foundation

enum CreteCustomerEndpoint {
    case createCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String)
    case editCustomerCoreInstallment(userCode:String,idCard:String,idCardType:Int    ,firstName:String,middleName:String,lastName:String,email:String,gender:Int,birthDate:String,phone:String,idCardIssuedBy:String,idCardIssuedDate:String,idCardIssuedExpiration:String,relatedDocument:[String:Any],company:[String:Any],refPersons:[[String:Any]],addresses:[[String:Any]],uploadFiles:[[String:Any]],relatedDocType:String)
    case loadInfoCustomer(id: String)
    case searchInfoCustomer(keyword: String,skipCount:Int,maxResultCount:Int)
    case deleteInfoCustomer(id: String)
//    case searchInfoCustomer(keyword: String,skipCount:Int,maxResultCount:Int)

}

extension CreteCustomerEndpoint: EndPointType {

    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .createCustomerCoreInstallment:
                return .post
            case .loadInfoCustomer,.searchInfoCustomer:
                return .get
            case .editCustomerCoreInstallment:
                return .put
            case .deleteInfoCustomer:
                return .delete

        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            //https://gatewaybeta.fptshop.com.vn/gateway/dev-installment-service/api/common/province
        switch self {
            case .createCustomerCoreInstallment:
                return BASE_URL + "/dev-installment-service/api/customer"
            case .editCustomerCoreInstallment:
                return BASE_URL + "/dev-installment-service/api/customer?id=\(CoreInstallMentData.shared.editID)"
            case .loadInfoCustomer:
                return BASE_URL + "/dev-installment-service/api/customer/\(CoreInstallMentData.shared.editID)"
            case .searchInfoCustomer(let keyword,let skipCount,let maxResultCount):
                return BASE_URL + "/dev-installment-service/api/customer?keyword=\(keyword)&skipCount=\(skipCount)&maxResultCount=\(maxResultCount)"
            case .deleteInfoCustomer:
                return BASE_URL + "/dev-installment-service/api/customer?id=\(CoreInstallMentData.shared.editID)"
        }
    }

    var parameters: JSONDictionary {
        switch self {
            case .createCustomerCoreInstallment(let userCode,let idCard,let idCardType,let firstName,let middleName,let lastName,let email,let gender,let birthDate,let phone,let idCardIssuedBy,let idCardIssuedDate,let idCardIssuedExpiration,let relatedDocument,let company,let refPersons,let addresses,let uploadFiles,let relatedDocType):
                return [
                    //FIXME: đổi param
                    "userCode": userCode,
                    "idCard": idCard,
                    "idCardType": idCardType,
                    "firstName": firstName,
                    "middleName": middleName,
                    "lastName": lastName,
                    "email": email,
                    "gender": gender,
                    "birthDate": birthDate,
                    "phone": phone,
                    "idCardIssuedBy": idCardIssuedBy,
                    "idCardIssuedDate": idCardIssuedDate,
                    "idCardIssuedExpiration": idCardIssuedExpiration,
                    "relatedDocument": relatedDocument,
                    "company": company,
                    "refPersons": refPersons,
                    "addresses": addresses,
                    "uploadFiles": uploadFiles,
                    "relatedDocType": relatedDocType,
                    "idCardIssuedByCode": CoreInstallMentData.shared.idCardIssuedByCode,
                ]
            case .editCustomerCoreInstallment(let userCode,let idCard,let idCardType,let firstName,let middleName,let lastName,let email,let gender,let birthDate,let phone,let idCardIssuedBy,let idCardIssuedDate,let idCardIssuedExpiration,let relatedDocument,let company,let refPersons,let addresses,let uploadFiles,let relatedDocType):
                return [
                    //FIXME: đổi param
                    "userCode": userCode,
                    "idCard": idCard,
                    "idCardType": idCardType,
                    "firstName": firstName,
                    "middleName": middleName,
                    "lastName": lastName,
                    "email": email,
                    "gender": gender,
                    "birthDate": birthDate,
                    "phone": phone,
                    "idCardIssuedBy": idCardIssuedBy,
                    "idCardIssuedDate": idCardIssuedDate,
                    "idCardIssuedExpiration": idCardIssuedExpiration,
                    "relatedDocument": relatedDocument,
                    "company": company,
                    "refPersons": refPersons,
                    "addresses": addresses,
                    "uploadFiles": uploadFiles,
                    "relatedDocType": relatedDocType,
                    "idCardIssuedByCode" : CoreInstallMentData.shared.editIdCardIssuedByCode,
                ]
            case .loadInfoCustomer(let id):
                return [
                    :
                ]
            case .deleteInfoCustomer(let id):
                return [
                    :
                ]
            case .searchInfoCustomer(let keyword,let skipCount,let maxResultCount):
                return [
                    "keyword": keyword,
                    "skipCount": skipCount,
                    "maxResultCount": maxResultCount
                ]
        }
    }
}
