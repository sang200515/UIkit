//
//  BookSimVinaphoneService.swift
//  QuickCode
//
//  Created by Sang Trương on 30/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol BookSimVinaphoneServiceProtocol {
	func  addOrder(param:AddBookSimVinaphoneParam, success: @escaping SuccessHandler<AddBookSimVinaphoneModel>.object, failure: @escaping RequestFailure)
	func getOrder( id:String,success: @escaping SuccessHandler<AddBookSimVinaphoneModel>.object, failure: @escaping RequestFailure)
	func getListActiveSim(type:String, success: @escaping SuccessHandler<ActiveSimVinaModel>.object, failure: @escaping RequestFailure)
}

class BookSimVinaphoneService: BookSimVinaphoneServiceProtocol {



	private let network: APINetworkProtocol

	init(network: APINetworkProtocol) {
		self.network = network
	}

	func addOrder(param:AddBookSimVinaphoneParam,success: @escaping SuccessHandler<AddBookSimVinaphoneModel>.object, failure: @escaping RequestFailure) {
		let endPoint = BookSimVinaphoneEndpoint.addOrder(param:param)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}

	func getOrder(id:String,success: @escaping SuccessHandler<AddBookSimVinaphoneModel>.object, failure: @escaping RequestFailure) {
		let endPoint = BookSimVinaphoneEndpoint.getOrder(id: id)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}

	func getListActiveSim(type:String,success: @escaping SuccessHandler<ActiveSimVinaModel>.object, failure: @escaping RequestFailure) {
		let endPoint = BookSimVinaphoneEndpoint.getListActiveSim(type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}


}

