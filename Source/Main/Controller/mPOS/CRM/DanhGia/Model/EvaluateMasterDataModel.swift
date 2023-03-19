//
//  EvaluateMasterDataModel.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Foundation
import ObjectMapper

class EvaluateMasterDataModel: Mappable {
	var hangMucGiaTri: [HangMucGiaTri]?
	var capDoDichVu: [CapDoDichVu]?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		hangMucGiaTri <- map["HangMucGiaTri"]
		capDoDichVu <- map["CapDoDichVu"]
	}

}
class CapDoDichVu: Mappable {
	var id: Int?
	var text: String?
	var note: String?
	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		id <- map["Id"]
		text <- map["Text"]
		note <- map["Note"]
	}

}

class HangMucGiaTri: Mappable {
	var id: Int?
	var text: String?
	var note: String?
	var isSelected:Bool = false
	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		id <- map["Id"]
		text <- map["Text"]
		note <- map["Note"]
	}

}
