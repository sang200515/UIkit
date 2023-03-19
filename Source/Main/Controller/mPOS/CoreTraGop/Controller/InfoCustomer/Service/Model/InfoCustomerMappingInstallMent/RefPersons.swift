

import Foundation
import ObjectMapper

class RefPersonsMapping : Mappable {
	var fullName : String?
	var relationshipCode : String?
	var relationshipName : String?
	var personNum : Int?
	var phone : String?
	var insHouseRefPerson : InsHouseWardMapping?

    required init?(map: Map) {

	}

	 func mapping(map: Map) {

		fullName <- map["fullName"]
		relationshipCode <- map["relationshipCode"]
		relationshipName <- map["relationshipName"]
		personNum <- map["personNum"]
		phone <- map["phone"]
		insHouseRefPerson <- map["insHouseRefPerson"]
	}

}
