

import Foundation
import ObjectMapper

class InsHouseWardMapping : Mappable {
	var miraeCode : String?
	var shinhanCode : String?
	var compCode : String?
	var hcCode : String?
	var feCode : String?

    required init?(map: Map) {

	}

	 func mapping(map: Map) {

		miraeCode <- map["miraeCode"]
		shinhanCode <- map["shinhanCode"]
		compCode <- map["compCode"]
		hcCode <- map["hcCode"]
		feCode <- map["feCode"]
	}

}
