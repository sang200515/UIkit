//    //
//    //  DetailInstallMentMapping.swift
//    //  QuickCode
//    //
//    //  Created by Sang Trương on 26/07/2022.
//    //
//
//import Foundation
//import ObjectMapper
//class MasterDataInstallMent : Mappable {
//    var idCard : String?
//    var idCardType : Int?
//    var idCardIssuedBy : String?
//    var idCardIssuedDate : String?
//    var idCardIssuedExpiration : String?
//    var firstName : String?
//    var middleName : String?
//    var lastName : String?
//    var email : String?
//    var phone : String?
//    var gender : Int?
//    var birthDate : String?
//    var relatedDocument : RelatedDocumentMapping?
//    var company : CompanyMapping?
//    var refPersons : [RefPersonsMapping]?
//    var addresses : [AddressesMapping]?
//    var uploadFiles : [UploadFilesMapping]?
//    var id : Int?
//
//    var fullName:String!{
//        return "\(firstName ?? "") " + "\(middleName ?? "") " + "\(lastName ?? "")"
//    }
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        idCard <- map["idCard"]
//        idCardType <- map["idCardType"]
//        idCardIssuedBy <- map["idCardIssuedBy"]
//        idCardIssuedDate <- map["idCardIssuedDate"]
//        idCardIssuedExpiration <- map["idCardIssuedExpiration"]
//        firstName <- map["firstName"]
//        middleName <- map["middleName"]
//        lastName <- map["lastName"]
//        email <- map["email"]
//        phone <- map["phone"]
//        gender <- map["gender"]
//        birthDate <- map["birthDate"]
//        relatedDocument <- map["relatedDocument"]
//        company <- map["company"]
//        refPersons <- map["refPersons"]
//        addresses <- map["addresses"]
//        uploadFiles <- map["uploadFiles"]
//        id <- map["id"]
//    }
//
//}
//class AddressesMapping : Mappable {
//    var provinceCode : String?
//    var provinceName : String?
//    var districtCode : String?
//    var districtName : String?
//    var wardCode : String?
//    var wardName : String?
//    var street : String?
//    var houseNo : String?
//    var fullAddress : String?
//    var addressType : Int?
//    var insHouseProvice : InsHouseProviceMapping?
//    var insHouseDistrict : InsHouseDistrictMapping?
//    var insHouseWard : InsHouseWardMapping?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        provinceCode <- map["provinceCode"]
//        provinceName <- map["provinceName"]
//        districtCode <- map["districtCode"]
//        districtName <- map["districtName"]
//        wardCode <- map["wardCode"]
//        wardName <- map["wardName"]
//        street <- map["street"]
//        houseNo <- map["houseNo"]
//        fullAddress <- map["fullAddress"]
//        addressType <- map["addressType"]
//        insHouseProvice <- map["insHouseProvice"]
//        insHouseDistrict <- map["insHouseDistrict"]
//        insHouseWard <- map["insHouseWard"]
//    }
//
//}
//class CompanyMapping : Mappable {
//    var companyName : String?
//    var companyAddress : String?
//    var position : String?
//    var income : Double?
//    var workYear : Int?
//    var workMonth : Int?
//    var companyPhone : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        companyName <- map["companyName"]
//        companyAddress <- map["companyAddress"]
//        position <- map["position"]
//        income <- map["income"]
//        workYear <- map["workYear"]
//        workMonth <- map["workMonth"]
//        companyPhone <- map["companyPhone"]
//    }
//
//}
//class InsHouseDistrictMapping : Mappable {
//    var miraeCode : String?
//    var shinhanCode : String?
//    var compCode : String?
//    var hcCode : String?
//    var feCode : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        miraeCode <- map["miraeCode"]
//        shinhanCode <- map["shinhanCode"]
//        compCode <- map["compCode"]
//        hcCode <- map["hcCode"]
//        feCode <- map["feCode"]
//    }
//
//}
//class InsHouseProviceMapping : Mappable {
//    var miraeCode : String?
//    var shinhanCode : String?
//    var compCode : String?
//    var hcCode : String?
//    var feCode : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        miraeCode <- map["miraeCode"]
//        shinhanCode <- map["shinhanCode"]
//        compCode <- map["compCode"]
//        hcCode <- map["hcCode"]
//        feCode <- map["feCode"]
//    }
//
//}
//class InsHouseRefPersonMapping : Mappable {
//    var miraeCode : String?
//    var shinhanCode : String?
//    var compCode : String?
//    var hcCode : String?
//    var feCode : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        miraeCode <- map["miraeCode"]
//        shinhanCode <- map["shinhanCode"]
//        compCode <- map["compCode"]
//        hcCode <- map["hcCode"]
//        feCode <- map["feCode"]
//    }
//
//}
//class InsHouseUploadFileMapping : Mappable {
//    var miraeCode : String?
//    var shinhanCode : String?
//    var compCode : String?
//    var hcCode : String?
//    var feCode : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        miraeCode <- map["miraeCode"]
//        shinhanCode <- map["shinhanCode"]
//        compCode <- map["compCode"]
//        hcCode <- map["hcCode"]
//        feCode <- map["feCode"]
//    }
//
//}
//class InsHouseWardMapping : Mappable {
//    var miraeCode : String?
//    var shinhanCode : String?
//    var compCode : String?
//    var hcCode : String?
//    var feCode : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        miraeCode <- map["miraeCode"]
//        shinhanCode <- map["shinhanCode"]
//        compCode <- map["compCode"]
//        hcCode <- map["hcCode"]
//        feCode <- map["feCode"]
//    }
//
//}
//class RefPersonsMapping : Mappable {
//    var fullName : String?
//    var relationshipCode : String?
//    var relationshipName : String?
//    var personNum : Int?
//    var phone : String?
//    var insHouseRefPerson : InsHouseRefPersonMapping?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        fullName <- map["fullName"]
//        relationshipCode <- map["relationshipCode"]
//        relationshipName <- map["relationshipName"]
//        personNum <- map["personNum"]
//        phone <- map["phone"]
//        insHouseRefPerson <- map["insHouseRefPerson"]
//    }
//
//}
//class RelatedDocumentMapping : Mappable {
//    var drivingLicNum : String?
//    var drivingLicNumDate : String?
//    var drivingLicNumBy : String?
//    var houseBookNum : String?
//    var houseBookName : String?
//    var houseBookAddress : String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        drivingLicNum <- map["drivingLicNum"]
//        drivingLicNumDate <- map["drivingLicNumDate"]
//        drivingLicNumBy <- map["drivingLicNumBy"]
//        houseBookNum <- map["houseBookNum"]
//        houseBookName <- map["houseBookName"]
//        houseBookAddress <- map["houseBookAddress"]
//    }
//
//}
//class UploadFilesMapping : Mappable {
//    var fileType : String?
//    var fileName : String?
//    var urlImage : String?
//    var insHouseUploadFile : InsHouseUploadFileMapping?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        fileType <- map["fileType"]
//        fileName <- map["fileName"]
//        urlImage <- map["urlImage"]
//        insHouseUploadFile <- map["insHouseUploadFile"]
//    }
//
//}
