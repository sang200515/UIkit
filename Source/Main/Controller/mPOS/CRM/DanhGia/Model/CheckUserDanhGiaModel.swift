//
//  CheckUserDanhGiaModel.swift
//  fptshop
//
//  Created by Sang Trương on 18/11/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class CheckUserDanhGiaModel : Mappable {
	var type : String?

	required init?(map: Map) {

	}

	func mapping(map: Map) {
		type <- map["Type"]

	}

}
