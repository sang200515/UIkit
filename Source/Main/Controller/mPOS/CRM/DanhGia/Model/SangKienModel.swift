//
//  SangKienModel.swift
//  fptshop
//
//  Created by Sang Trương on 10/11/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

class SangKienModel : Mappable {
	var SangKien1 : String?
	var SangKien2 : String?
	var SangKien3 : String?
	var SangKien4 : String?
	var SangKien5 : String?
	var SangKien6 : String?
	var SangKien7 : String?
	var SangKien8 : String?
	var SangKien9 : String?
	var SangKien10 : String?
	var errorMessage:String = ""
	required init?(map: Map) {

	}

	func mapping(map: Map) {

		SangKien1 <- map["SangKien1"]
		SangKien2 <- map["SangKien2"]
		SangKien3 <- map["SangKien3"]
		SangKien4 <- map["SangKien4"]
		SangKien5 <- map["SangKien5"]
		SangKien6 <- map["SangKien6"]
		SangKien7 <- map["SangKien7"]
		SangKien8 <- map["SangKien8"]
		SangKien9 <- map["SangKien9"]
		SangKien10 <- map["SangKien10"]

	}

}
