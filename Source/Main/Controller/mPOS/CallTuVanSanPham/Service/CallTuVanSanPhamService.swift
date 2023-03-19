	//
	//  CallTuVanSanPhamService.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//



import Foundation
import Alamofire
import SwiftyJSON

protocol CallTuVanSanPhamProtocol {
	func loadListCustomer(type:String,success: @escaping SuccessHandler<CallTuVanSanPhamModel>.object, failure: @escaping RequestFailure)
	func updateCustomer(id:String,phone:String, success: @escaping SuccessHandler<TuVanSanPhamUpdateModel>.object, failure: @escaping RequestFailure)
}

class CallTuVanSanPhamService: CallTuVanSanPhamProtocol {

	private let network: APINetworkProtocol

	init(network: APINetworkProtocol) {
		self.network = network
	}

	func loadListCustomer(type:String, success: @escaping SuccessHandler<CallTuVanSanPhamModel>.object, failure: @escaping RequestFailure) {
		let endPoint = CallTuVanSanPhamEndpoint.loadListCustomer(type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func updateCustomer(id:String,phone:String, success: @escaping SuccessHandler<TuVanSanPhamUpdateModel>.object, failure: @escaping RequestFailure) {
		let endPoint = CallTuVanSanPhamEndpoint.updateCustomer(id: id, phone: phone)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
}

