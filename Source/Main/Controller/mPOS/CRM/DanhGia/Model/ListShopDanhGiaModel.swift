//
//  ListShopDanhGiaModel.swift
//  fptshop
//
//  Created by Sang Trương on 18/11/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class ListShopDanhGiaModel : Mappable {
	var warehouseCode : String?
	var warehouseName : String?
	var status : String?
	var Message : String?

 required init?(map: Map) {

	}

	 func mapping(map: Map) {

		warehouseCode <- map["WarehouseCode"]
		warehouseName <- map["WarehouseName"]
		 status <- map["status"]
		 Message <- map["Message"]
	}

}
