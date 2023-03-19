//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class EbayFeeModel: Mappable {
	var customerIdNo: String?
	var customerIdDate: String?
	var customerIdPlace: String?
	var customerName: String?
	var expireDate: String?
	var amount: Double?
	var requireSecurityCode: Int?
	var error: ErrorEbay?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		customerIdNo <- map["customerIdNo"]
		customerIdDate <- map["customerIdDate"]
		customerIdPlace <- map["customerIdPlace"]
		customerName <- map["customerName"]
		expireDate <- map["expireDate"]
		amount <- map["amount"]
		requireSecurityCode <- map["requireSecurityCode"]
		error <- map["error"]
	}

}
class ErrorEbay: Mappable {
	var extraProperties: ExtraPropertiesEbay?
	var code: String?
	var message: String?
	var details: String?
	var validationErrors: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		extraProperties <- map["ExtraPropertiesEbay"]
		code <- map["code"]
		message <- map["message"]
		details <- map["details"]
		validationErrors <- map["validationErrors"]
	}

}
class ExtraPropertiesEbay: Mappable {

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

	}

}
