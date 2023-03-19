//
//  UpdateBienLai.swift
//  QuickCode
//
//  Created by Sang Trương on 09/08/2022.
//

import Foundation
import ObjectMapper

class UpdateBienLaiEbayModel: Mappable {
	var message: String?
	var code: Int?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		message <- map["message"]
		code <- map["code"]
	}

}
