	//
	//  DetailHistoryEveluateModel.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 01/11/2022.
	//

import Foundation
import ObjectMapper

class DetailHistoryEveluateModel : Mappable {
	var tenNhanVien : String?
	var hangMucGiaTri : [String]?
	var capDoDichVu : String?
	var lyDo : String?
	var PhongBan : String?
	required init?(map: Map) {

	}

	func mapping(map: Map) {

		tenNhanVien <- map["TenNhanVien"]
		hangMucGiaTri <- map["HangMucGiaTri"]
		capDoDichVu <- map["CapDoDichVu"]
		lyDo <- map["LyDo"]
		PhongBan <- map["PhongBan"]
		}

}
