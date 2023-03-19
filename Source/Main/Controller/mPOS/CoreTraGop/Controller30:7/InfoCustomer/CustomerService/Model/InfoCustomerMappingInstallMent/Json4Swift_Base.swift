import Foundation
import ObjectMapper

class MasterDataInstallMent: Mappable {
    var idCardIssuedExpiration : String?
    var company : CompanyMapping?
    var addresses : [AddressesMapping]?
    var idCardTypeName : String?
    var birthDate : String?
    var relatedDocType : String?
    var idCardIssuedDate : String?
    var idCardIssued : IdCardIssuedMapping?
    var idCard : String?
    var id : Int?
    var gender : Int?
    var email : String?
    var relatedDocument : RelatedDocumentMapping?
    var middleName : String?
    var phone : String?
    var firstName : String?
    var idCardType : Int?
    var refPersons : [RefPersonsMapping]?
    var uploadFiles : [UploadFilesMapping]?
    var lastName : String?

	var fullName: String {
		return "\(lastName ?? "") \(middleName ?? "") \(firstName ?? "")"
	}
	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

        idCardIssuedExpiration <- map["idCardIssuedExpiration"]
        company <- map["company"]
        addresses <- map["addresses"]
        idCardTypeName <- map["idCardTypeName"]
        birthDate <- map["birthDate"]
        relatedDocType <- map["relatedDocType"]
        idCardIssuedDate <- map["idCardIssuedDate"]
        idCardIssued <- map["idCardIssued"]
        idCard <- map["idCard"]
        id <- map["id"]
        gender <- map["gender"]
        email <- map["email"]
        relatedDocument <- map["relatedDocument"]
        middleName <- map["middleName"]
        phone <- map["phone"]
        firstName <- map["firstName"]
        idCardType <- map["idCardType"]
        refPersons <- map["refPersons"]
        uploadFiles <- map["uploadFiles"]
        lastName <- map["lastName"]

	}

}
