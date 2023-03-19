//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemsEbay: Mappable {
	var code: String?
	var name: String?
	var id: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		code <- map["code"]
		name <- map["name"]
		id <- map["id"]
	}

}
class EbayListFinicial: Mappable {
	var totalCount: Int?
	var items: [ItemsEbay]?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		totalCount <- map["totalCount"]
		items <- map["items"]
	}

}

class EbaySaveOrderModel: Mappable {
	var id: String?
	var customerId: String?
	var error: ErrorEbay?
	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		customerId <- map["customerId"]
		error <- map["error"]
	}

}
