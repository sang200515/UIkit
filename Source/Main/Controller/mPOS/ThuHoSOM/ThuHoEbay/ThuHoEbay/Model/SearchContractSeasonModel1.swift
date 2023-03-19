//
//  SearchContractSeasonModel.swift
//  fptshop
//
//  Created by Sang Trương on 06/12/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchContractSeasonModel1: Mappable {
	var customerPhoneNumber: String?
	var customerName: String?
	var address: String?
	var contractId: String?
	var contractNo: String?
	var serviceId: String?
	var serviceName: String?
	var providerId: String?
	var providerName: String?
	var description: String?
	var totalAmount: String?
	var totalFee: String?
	var referenceCode: String?
	var paymentFeeType: String?
	var percentFee: String?
	var constantFee: String?
	var minFee: String?
	var maxFee: String?
	var minAmount: String?
	var paymentRule: String?
	var isOfflineTransaction: String?
	var warehouseAddress: String?
	var ipAddress: String?
	var invoices: String?
	var additionalDataModel: AdditionalDataModel?
	var extraProperties: ExtraPropertiesModel?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		customerPhoneNumber <- map["customerPhoneNumber"]
		customerName <- map["customerName"]
		address <- map["address"]
		contractId <- map["contractId"]
		contractNo <- map["contractNo"]
		serviceId <- map["serviceId"]
		serviceName <- map["serviceName"]
		providerId <- map["providerId"]
		providerName <- map["providerName"]
		description <- map["description"]
		totalAmount <- map["totalAmount"]
		totalFee <- map["totalFee"]
		referenceCode <- map["referenceCode"]
		paymentFeeType <- map["paymentFeeType"]
		percentFee <- map["percentFee"]
		constantFee <- map["constantFee"]
		minFee <- map["minFee"]
		maxFee <- map["maxFee"]
		minAmount <- map["minAmount"]
		paymentRule <- map["paymentRule"]
		isOfflineTransaction <- map["isOfflineTransaction"]
		warehouseAddress <- map["warehouseAddress"]
		ipAddress <- map["ipAddress"]
		invoices <- map["invoices"]
		additionalDataModel <- map["additionalData"]
		extraProperties <- map["extraProperties"]
	}

}

class SuggestionsModel: Mappable {
	var customerPhoneNumber: String?
	var customerName: String?
	var address: String?
	var contractId: String?
	var contractNo: String?
	var serviceId: String?
	var serviceName: String?
	var providerId: String?
	var providerName: String?
	var description: String?
	var totalAmount: String?
	var totalFee: String?
	var referenceCode: String?
	var paymentFeeType: String?
	var percentFee: String?
	var constantFee: String?
	var minFee: String?
	var maxFee: String?
	var minAmount: String?
	var paymentRule: String?
	var isOfflineTransaction: String?
	var warehouseAddress: String?
	var ipAddress: String?
	var invoices: String?
	var additionalData: AdditionalDataModel?
	var extraProperties: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		customerPhoneNumber <- map["customerPhoneNumber"]
		customerName <- map["customerName"]
		address <- map["address"]
		contractId <- map["contractId"]
		contractNo <- map["contractNo"]
		serviceId <- map["serviceId"]
		serviceName <- map["serviceName"]
		providerId <- map["providerId"]
		providerName <- map["providerName"]
		description <- map["description"]
		totalAmount <- map["totalAmount"]
		totalFee <- map["totalFee"]
		referenceCode <- map["referenceCode"]
		paymentFeeType <- map["paymentFeeType"]
		percentFee <- map["percentFee"]
		constantFee <- map["constantFee"]
		minFee <- map["minFee"]
		maxFee <- map["maxFee"]
		minAmount <- map["minAmount"]
		paymentRule <- map["paymentRule"]
		isOfflineTransaction <- map["isOfflineTransaction"]
		warehouseAddress <- map["warehouseAddress"]
		ipAddress <- map["ipAddress"]
		invoices <- map["invoices"]
		additionalData <- map["additionalData"]
		extraProperties <- map["extraProperties"]
	}

}
class AdditionalDataModel: Mappable {
	var pin: String?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		pin <- map["pin"]
	}

}
class ExtraPropertiesModel: Mappable {
	var suggestionsModel: [SuggestionsModel]?

	required init?(
		map: Map
	) {

	}

	func mapping(map: Map) {

		suggestionsModel <- map["suggestions"]
	}

}
