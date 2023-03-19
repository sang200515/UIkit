//
//  CreateCustomerModel.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import Foundation
import ObjectMapper

//detech cmnd

class DetechCMNDCoreModel : Mappable {
    var idCard : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var birthDate : String?
    var proviceCode : String?
    var proviceName : String?
    var districtCode : String?
    var districtName : String?
    var wardCode : String?
    var wardName : String?
    var street : String?
    var idCardIssuedBy : String?
    var idCardIssuedDate : String?
    var idCardIssuedExpiration : String?

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        idCard <- map["idCard"]
        firstName <- map["firstName"]
        middleName <- map["middleName"]
        lastName <- map["lastName"]
        birthDate <- map["birthDate"]
        proviceCode <- map["proviceCode"]
        proviceName <- map["proviceName"]
        districtCode <- map["districtCode"]
        districtName <- map["districtName"]
        wardCode <- map["wardCode"]
        wardName <- map["wardName"]
        street <- map["street"]
        idCardIssuedBy <- map["idCardIssuedBy"]
        idCardIssuedDate <- map["idCardIssuedDate"]
        idCardIssuedExpiration <- map["idCardIssuedExpiration"]
    }

}
class CreateCustomerModel: Mappable {
	var userCode: String?
	var idCard: String?
	var firstName: String?
	var middleName: String?
	var lastName: String?
	var email: String?
	var gender: Int?
	var birthDate: String?
	var phone: String?
	var idCardIssuedBy: String?
    var idCardIssuedByCode: String?
	var idCardIssuedDate: String?
	var idCardIssuedExpiration: String?
    var idCardType: Int?
    var idCardTypeName: String?
    var relatedDocType: String?
	var relatedDocument: CreateRelatedDocument?
	var company: CreateCompany?
	var refPersons: [CreateRefPersons]?
	var addresses: [CreateAddresses]?
	var uploadFiles: [CreateUploadFiles]?
	var id: Int?
    var fullName:String{
        return "\(lastName ?? "") \(middleName ?? "") \(firstName ?? "")"
    }
	required init?(
		map: Map
	) {

	}

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
        idCardIssuedByCode <- map["idCardIssuedByCode"]
		idCardIssuedDate <- map["idCardIssuedDate"]
		idCardIssuedExpiration <- map["idCardIssuedExpiration"]
        idCardType <- map["idCardType"]
        idCardTypeName <- map["idCardTypeName"]
        relatedDocType <- map["relatedDocType"]
		relatedDocument <- map["relatedDocument"]
		company <- map["company"]
		refPersons <- map["refPersons"]
		addresses <- map["addresses"]
		uploadFiles <- map["uploadFiles"]
		id <- map["id"]
	}

}

class CreateAddresses: Mappable {
	var provinceCode: String?
	var provinceName: String?
	var districtCode: String?
	var districtName: String?
	var wardCode: String?
	var wardName: String?
	var street: String?
	var houseNo: String?
	var fullAddress: String?
	var addressType: Int?
	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		provinceCode <- map["provinceCode"]
		provinceName <- map["provinceName"]
		districtCode <- map["districtCode"]
		districtName <- map["districtName"]
		wardCode <- map["wardCode"]
		wardName <- map["wardName"]
		street <- map["street"]
		houseNo <- map["houseNo"]
		fullAddress <- map["fullAddress"]
		addressType <- map["addressType"]
	}

}

class CreateCompany: Mappable {
	var companyName: String = ""
	var companyAddress: String = ""
	var position: String = ""
    var companyPhone: String = ""
	var income: Float = 0
	var workYear: Float = 0
	var workMonth: Float = 0

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		companyName <- map["companyName"]
		companyAddress <- map["companyAddress"]
		position <- map["position"]
		income <- map["income"]
		workYear <- map["workYear"]
		workMonth <- map["workMonth"]
        companyPhone <- map["companyPhone"]

	}

}

class CreateRefPersons: Mappable {
	var fullName: String = ""
	var relationshipCode: String = ""
    var relationshipName: String = ""
	var personNum: Int = 0
	var phone: String = ""

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		fullName <- map["fullName"]
		relationshipCode <- map["relationshipCode"]
        relationshipName <- map["relationshipName"]
		personNum <- map["personNum"]
		phone <- map["phone"]
	}

}

class CreateRelatedDocument: Mappable {
	var drivingLicNum: String = ""
	var drivingLicNumDate: String = ""
	var drivingLicNumBy: String = ""
	var houseBookNum: String = ""
	var houseBookName: String = ""
	var houseBookAddress: String = ""

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		drivingLicNum <- map["drivingLicNum"]
		drivingLicNumDate <- map["drivingLicNumDate"]
		drivingLicNumBy <- map["drivingLicNumBy"]
		houseBookNum <- map["houseBookNum"]
		houseBookName <- map["houseBookName"]
		houseBookAddress <- map["houseBookAddress"]
	}

}

class CreateUploadFiles: Mappable {
	var fileType: String?
	var fileName: String?
    var urlImage: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		fileType <- map["fileType"]
		fileName <- map["fileName"]
        urlImage <- map["urlImage"]

	}

}
