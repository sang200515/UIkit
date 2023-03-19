//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class TransactionCheckEbayModel: Mappable {
	var orderId: String?
	var status: String?
	var requestId: String?
	var returnedTransactionId: String?
	var errorCode: String?
	var errorMsg: String?
	var cancelAcceptedAmount: String?
	var extraProperties: ExtraPropertiesTranSactionEbay?
	var error: ErrorEbay?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		orderId <- map["orderId"]
		status <- map["status"]
		requestId <- map["requestId"]
		returnedTransactionId <- map["returnedTransactionId"]
		errorCode <- map["errorCode"]
		errorMsg <- map["errorMsg"]
		cancelAcceptedAmount <- map["cancelAcceptedAmount"]
		extraProperties <- map["extraProperties"]
		error <- map["error"]
	}

}
class ExtraPropertiesTranSactionEbay: Mappable {

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

	}

}

class TransactionCheckEbayNewModel: Mappable {
    var orderStatus: Int?
    var message: String?

    required init?(
        map: Map
    ) {

    }

    func mapping(map: Map) {

        orderStatus <- map["orderStatus"]
        message <- map["message"]

    }

}
