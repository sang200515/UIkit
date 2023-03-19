
import Foundation
import ObjectMapper

class RelatedDocumentMapping : Mappable {
	var drivingLicNum : String?
	var drivingLicNumDate : String?
	var drivingLicNumBy : String?
	var houseBookNum : String?
	var houseBookName : String?
	var houseBookAddress : String?

    required init?(map: Map) {

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
