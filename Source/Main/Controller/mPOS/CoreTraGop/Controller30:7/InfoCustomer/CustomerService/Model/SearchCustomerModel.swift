//
//  SearchCustomerModel.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//


import Foundation
import ObjectMapper

class DataSearchCustomer : Mappable {
    var totalCount : Int?
    var items : [ItemsSearchCustomer]?

    required init?(map: Map) { }


     func mapping(map: Map) {

        totalCount <- map["totalCount"]
        items <- map["items"]
    }

}
class ItemsSearchCustomer : Mappable {
    var userCode : String?
    var idCard : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var email : String?
    var gender : Int?
    var birthDate : String?
    var phone : String?
    var idCardIssuedBy : String?
    var idCardIssuedDate : String?
    var idCardIssuedExpiration : String?
    var relatedDocument : RelatedDocumentSearchCustomer?
    var relatedDocType : String?
    var company : CompanySearchCustomer?
    var refPersons : String?
    var addresses : String?
    var uploadFiles : String?
    var id : Int?

    var fullName :String {
        return "\(lastName ?? "") \(middleName ?? "") \(firstName ?? "")" 
    }
    required init?(map: Map) { }


    func mapping(map: Map) {

        userCode <- map["userCode"]
        idCard <- map["idCard"]
        firstName <- map["firstName"]
        middleName <- map["middleName"]
        lastName <- map["lastName"]
        email <- map["email"]
        gender <- map["gender"]
        birthDate <- map["birthDate"]
        phone <- map["phone"]
        idCardIssuedBy <- map["idCardIssuedBy"]
        idCardIssuedDate <- map["idCardIssuedDate"]
        idCardIssuedExpiration <- map["idCardIssuedExpiration"]
        relatedDocument <- map["relatedDocument"]
        relatedDocType <- map["relatedDocType"]

        company <- map["company"]
        refPersons <- map["refPersons"]
        addresses <- map["addresses"]
        uploadFiles <- map["uploadFiles"]
        id <- map["id"]
    }

}
class CompanySearchCustomer : Mappable {
    var companyName : String?
    var companyAddress : String?
    var position : String?
    var income : Double?
    var workYear : Int?
    var workMonth : Int?

    required init?(map: Map) { }

     func mapping(map: Map) {

        companyName <- map["companyName"]
        companyAddress <- map["companyAddress"]
        position <- map["position"]
        income <- map["income"]
        workYear <- map["workYear"]
        workMonth <- map["workMonth"]
    }

}




class RelatedDocumentSearchCustomer : Mappable {
    var drivingLicNum : String?
    var drivingLicNumDate : String?
    var drivingLicNumBy : String?
    var houseBookNum : String?
    var houseBookName : String?
    var houseBookAddress : String?

    required init?(map: Map) { }

     func mapping(map: Map) {

        drivingLicNum <- map["drivingLicNum"]
        drivingLicNumDate <- map["drivingLicNumDate"]
        drivingLicNumBy <- map["drivingLicNumBy"]
        houseBookNum <- map["houseBookNum"]
        houseBookName <- map["houseBookName"]
        houseBookAddress <- map["houseBookAddress"]
    }

}
