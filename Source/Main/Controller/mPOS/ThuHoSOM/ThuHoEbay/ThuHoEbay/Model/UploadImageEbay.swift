//
//  UploadImageEbay.swift
//  QuickCode
//
//  Created by Sang Trương on 08/08/2022.
//

import Foundation
import ObjectMapper

class UpLoadImageEbayModel: Mappable {
	var error: String?
	var url: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		error <- map["error"]
		url <- map["url"]
	}

}
