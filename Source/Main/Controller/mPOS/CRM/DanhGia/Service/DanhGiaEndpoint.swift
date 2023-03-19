//
//  DanhGiaEndpoint.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Alamofire
import Foundation

enum DanhGiaEndpoint {
	case loadMasterData
	case searchEmployee(loaiDanhGia: Int, typeSearch: String, keySearch: String,shopCode:String)
	case doneEvaluate(
		loaiDanhGia: Int, nhanVien: String, cuaHangPhongBan: String, hangMucGiaTri: String, capDoDichVu: String,
		lyDo: String)
	case doneInitiative(param: [String: String])
	case searchHistory(fromDate: String, toDate: String, keySearch: String, type: Int)
	case loadDetailHistory(id: Int, type: Int)
	case loadDetailNotification(id: Int)
	case checkUser
	case loadListShopOrASM(type: String)
}

extension DanhGiaEndpoint: EndPointType {

	var headers: HTTPHeaders? {
		return DefaultHeader().addAuthHeader()
	}

	var httpMethod: HTTPMethod {
		switch self {
			case .loadMasterData,.checkUser,.loadListShopOrASM:
			return .get
		default:
			return .post
		}
	}
	var path: String {
		let BASE_URL = Config.manager.URL_GATEWAY! + "/mpos-cloud-api"
		switch self {
		case .loadMasterData:
			return BASE_URL + "/api/ServiceReviews/LoadMasterData"
		case .searchEmployee:
			return BASE_URL + "/api/ServiceReviews/SearchNhanVien"
		case .doneEvaluate:
			return BASE_URL + "/api/ServiceReviews/CompleteSaveDanhGia"
		case .doneInitiative:
			return BASE_URL + "/api/ServiceReviews/CompleteSaveSangKien"
		case .searchHistory:
			return BASE_URL + "/api/ServiceReviews/SearchHistory"
		case .loadDetailHistory(_, _):
			return BASE_URL + "/api/ServiceReviews/LoadDetailsHistoryByID"
		case .loadDetailNotification(_):
			return BASE_URL + "/api/ServiceReviews/LoadContentNotification"
		case .checkUser:
			return BASE_URL + "/api/ServiceReviews/CheckUserShop?Usercode=\(Cache.user!.UserName)"
		case .loadListShopOrASM(let type):
			return BASE_URL + "/api/ServiceReviews/GetShopbyASM?Usercode=\(Cache.user!.UserName)&Type=\(type)"
		}
	}
	var parameters: JSONDictionary {
		switch self {
		case .loadMasterData:
			return [:]

		case .searchEmployee(let loaiDanhGia, let typeSearch, let keySearch,let shopCode):
			return [
				"userCode": Cache.user!.UserName,
				"shopCode": shopCode,
				"loaiDanhGia": loaiDanhGia,
				"typeSearch": typeSearch,
				"keySearch": keySearch,
			]
		case .doneEvaluate(
			let loaiDanhGia, let nhanVien, let cuaHangPhongban, let hangMucGiaTri, let capDoDichVu, let lyDo
		):
			return [
				"userCode": Cache.user!.UserName,
				"shopCode": Cache.user!.ShopCode,
				"device": 2,
				"loaiDanhGia": loaiDanhGia,
				"nhanVien": nhanVien,
				"cuaHangPhongban": cuaHangPhongban,
				"hangMucGiaTri": hangMucGiaTri,
				"capDoDichVu": capDoDichVu,
				"lyDo": lyDo,
			]
		case .doneInitiative(let param):
			return param
		case .searchHistory(let fromDate, let toDate, let keySearch, let type):
			return [
				"userCode": Cache.user!.UserName,
				"shopCode": Cache.user!.ShopCode,
				"type": type,
				"fromdate": fromDate,
				"todate": toDate,
				"keySearch": keySearch,
			]
		case .loadDetailHistory(let id, let type):
			return [
				"userCode": Cache.user!.UserName,
				"shopCode": Cache.user!.ShopCode,
				"type": type,
				"id": id,
			]
		case .loadDetailNotification(let id):
				return  [
					"UserCode": Cache.user!.UserName,
					"ShopCode": Cache.user!.ShopCode,
					"id": id,
				]
		case .checkUser:
			return [:]
		case .loadListShopOrASM(let _):
			return [:]
		}
	}
}
