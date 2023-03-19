	//
	//  CallTuVanSanPhamEndpoint.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import Foundation
import Alamofire

enum CallTuVanSanPhamEndpoint {
	case loadListCustomer(type : String)
	case updateCustomer(id : String,phone : String)

}

extension CallTuVanSanPhamEndpoint: EndPointType {

	var headers: HTTPHeaders? {
		return DefaultHeader().addAuthHeader()
	}

	var httpMethod: HTTPMethod {
		switch self {
			case .loadListCustomer:
				return .get
			case .updateCustomer:
				return .post
		}
	}

	var path: String {
		let BASE_URL = Config.manager.URL_GATEWAY!
		switch self {
			case .loadListCustomer(let type):
				return	BASE_URL + "/mpos-cloud-api/api/Customer/mpos_FRT_Call_Customer_Installment?shopCode=\(Cache.user!.ShopCode)&userCode=\(Cache.user!.UserName)&type=\(type)"
			case .updateCustomer:
				return  BASE_URL +  "/mpos-cloud-api/api/Customer/mpos_FRT_Call_Customer_UpdateInfo"
		}
	}

	var parameters: JSONDictionary {
		switch self {

			case .loadListCustomer(_):
				return [:]
			case .updateCustomer(id: let id, phone: let phone):
				return [
					"UserCode": Cache.user!.UserName,
					"ShopCode": Cache.user!.ShopCode,
					"ID": id,
					"Phone": "\(phone)"
				]

		}
	}
}
