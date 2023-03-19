	//
	//  CallTuVanSanPhamModel.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import Foundation
import ObjectMapper
class CallTuVanSanPhamModel : Mappable {
	var success : Bool?
	var data : [CallTuVanSanPhamDataModel]?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["Success"]
		data <- map["Data"]
	}

}
struct CallTuVanSanPhamDataModel : Mappable {
	var id : Int?
	var phone : String?
	var customerName : String?
	var idCard : String?
	var model : String?
	var status : String?
	var statusColor : String?
	var installmentHouse : String?
	var tenure : String?
	var purchaseDate : String?
	var employeeName : String?
	var callDate : String?

	 init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		phone <- map["phone"]
		customerName <- map["customerName"]
		idCard <- map["idCard"]
		model <- map["model"]
		status <- map["status"]
		statusColor <- map["statusColor"]
		installmentHouse <- map["InstallmentHouse"]
		tenure <- map["tenure"]
		purchaseDate <- map["purchaseDate"]
		employeeName <- map["employeeName"]
		callDate <- map["callDate"]
	}

}


class DataUpdateTuVanSanPhamModel : Mappable{
	var result : Int?
	var message : String?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		result <- map["Result"]
		message <- map["Message"]
	}
}
class TuVanSanPhamUpdateModel : Mappable {
	var success : Bool?
	var data : DataUpdateTuVanSanPhamModel?
	var message : String?
	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["Success"]
		data <- map["Data"]
		message <- map["Message"]
	}

}
