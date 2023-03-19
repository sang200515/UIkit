

import Foundation
import ObjectMapper

class CompanyMapping : Mappable {
	var companyName : String?
	var companyAddress : String?
	var position : String?
	var income : Double?
	var workYear : Int?
	var workMonth : Int?
	var companyPhone : String?

    required init?(map: Map) {

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
