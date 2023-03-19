
import Foundation
import ObjectMapper

class AddressesMapping : Mappable {
	var provinceCode : String?
	var provinceName : String?
	var districtCode : String?
	var districtName : String?
	var wardCode : String?
	var wardName : String?
	var street : String?
	var houseNo : String?
	var fullAddress : String?
	var addressType : Int?
	var insHouseProvice : InsHouseProviceMapping?
	var insHouseDistrict : InsHouseDistrictMapping?
	var insHouseWard : InsHouseWardMapping?

    required init?(map: Map) {

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
		insHouseProvice <- map["insHouseProvice"]
		insHouseDistrict <- map["insHouseDistrict"]
		insHouseWard <- map["insHouseWard"]
	}

}
