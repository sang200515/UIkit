//
//  DanhGiaService.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Alamofire
import Foundation
import SwiftyJSON

//https://confluence.fptshop.com.vn/pages/viewpage.action?pageId=110071912
protocol DanhGiaServiceProtocol {
	func loadMasterData(
		success: @escaping SuccessHandler<EvaluateMasterDataModel>.object, failure: @escaping RequestFailure)
	func searchEmployee(
		loaiDanhGia: Int, typeSearch: String, keySearch: String,shopCode:String,
		success: @escaping SuccessHandler<CustomerEveluateModel>.array, failure: @escaping RequestFailure
	)
	func doneEvaluate(
		loaiDanhGia: Int, nhanVien: String, cuaHangPhongBan: String, hangMucGiaTri: String, capDoDichVu: String,
		lyDo: String, success: @escaping SuccessHandler<DoneEveluateModel>.object,
		failure: @escaping RequestFailure)
	func doneInitiative(
		param: [String: String], success: @escaping SuccessHandler<DoneInitiativeModel>.object,
		failure: @escaping RequestFailure)
	func searchHistory(
		fromDate: String, toDate: String, keySearch: String, type: Int,
		success: @escaping SuccessHandler<SearchHistoryEveluateModel>.array, failure: @escaping RequestFailure)
	func loadDetailHistory(
		id: Int, type: Int, success: @escaping SuccessHandler<DetailHistoryEveluateModel>.object,
		failure: @escaping RequestFailure)
	func loadContentNotification(
		id: Int, success: @escaping SuccessHandler<ContentNotificationDanhGiaModel>.object,
		failure: @escaping RequestFailure)
	func loadDetailHistorySangKien(
		id: Int, type: Int, success: @escaping SuccessHandler<SangKienModel>.object,
		failure: @escaping RequestFailure
	)
	func checkUser(
		success: @escaping SuccessHandler<CheckUserDanhGiaModel>.object,
		failure: @escaping RequestFailure)
	func loadListShopOrASM( type: String, success: @escaping SuccessHandler<ListShopDanhGiaModel>.array,
		failure: @escaping RequestFailure
	)
}

class DanhGiaService: DanhGiaServiceProtocol {



	private let network: APINetworkProtocol

	init(
		network: APINetworkProtocol
	) {
		self.network = network
	}

	func loadMasterData(
		success: @escaping SuccessHandler<EvaluateMasterDataModel>.object, failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.loadMasterData
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func searchEmployee(
		loaiDanhGia: Int, typeSearch: String, keySearch: String,shopCode:String,
		success: @escaping SuccessHandler<CustomerEveluateModel>.array, failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.searchEmployee(
			loaiDanhGia: loaiDanhGia, typeSearch: typeSearch, keySearch: keySearch, shopCode: shopCode)
		network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
	}
	func doneEvaluate(
		loaiDanhGia: Int, nhanVien: String, cuaHangPhongBan: String, hangMucGiaTri: String, capDoDichVu: String,
		lyDo: String, success: @escaping SuccessHandler<DoneEveluateModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.doneEvaluate(
			loaiDanhGia: loaiDanhGia, nhanVien: nhanVien, cuaHangPhongBan: cuaHangPhongBan,
			hangMucGiaTri: hangMucGiaTri, capDoDichVu: capDoDichVu, lyDo: lyDo)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func doneInitiative(
		param: [String: String], success: @escaping SuccessHandler<DoneInitiativeModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.doneInitiative(param: param)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func searchHistory(
		fromDate: String, toDate: String, keySearch: String, type: Int,
		success: @escaping SuccessHandler<SearchHistoryEveluateModel>.array, failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.searchHistory(
			fromDate: fromDate, toDate: toDate, keySearch: keySearch, type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
	}
	func loadDetailHistory(
		id: Int, type: Int, success: @escaping SuccessHandler<DetailHistoryEveluateModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.loadDetailHistory(id: id, type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func loadDetailHistorySangKien(
		id: Int, type: Int, success: @escaping SuccessHandler<SangKienModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.loadDetailHistory(id: id, type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func loadContentNotification(
		id: Int, success: @escaping SuccessHandler<ContentNotificationDanhGiaModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.loadDetailNotification(id: id)
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func checkUser(success: @escaping SuccessHandler<CheckUserDanhGiaModel>.object,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.checkUser
		network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
	}
	func loadListShopOrASM( type: String, success: @escaping SuccessHandler<ListShopDanhGiaModel>.array,
		failure: @escaping RequestFailure
	) {
		let endPoint = DanhGiaEndpoint.loadListShopOrASM(type: type)
		network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
	}

}
