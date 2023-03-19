
import Foundation
import ObjectMapper

class UploadFilesMapping : Mappable {
	var fileType : String?
	var fileName : String?
	var urlImage : String?
	var insHouseUploadFile : InsHouseUploadFile?

    required init?(map: Map) {

	}

	 func mapping(map: Map) {

		fileType <- map["fileType"]
		fileName <- map["fileName"]
		urlImage <- map["urlImage"]
		insHouseUploadFile <- map["insHouseUploadFile"]
	}

}
class InsHouseUploadFile : Mappable {
    var shinhanCode : String?
    var compCode : String?
    var miraeCode : String?
    var hcCode : String?
    var feCode : String?

   required init?(map: Map) {

    }

     func mapping(map: Map) {

        shinhanCode <- map["shinhanCode"]
        compCode <- map["compCode"]
        miraeCode <- map["miraeCode"]
        hcCode <- map["hcCode"]
        feCode <- map["feCode"]
    }

}
