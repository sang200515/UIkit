	//
	//  BookSimVinaphoneEndpoint.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 30/12/2022.
	//

import Foundation
import Alamofire

enum BookSimVinaphoneEndpoint {
	case addOrder(param : AddBookSimVinaphoneParam)
	case getOrder(id:String)
	case getListActiveSim(type:String)
}

extension BookSimVinaphoneEndpoint: EndPointType {

	var headers: HTTPHeaders? {
		return DefaultHeader().addAuthHeader()
	}

	var httpMethod: HTTPMethod {
		switch self {
			case .getOrder,.getListActiveSim:
				return .get
			default :
				return .post
		}
	}

	var path: String {
		var BaseURL = ""
		let target = Bundle.main.infoDictionary?["TargetName"] as? String
		switch target {
			case "fptshop", "Production":
				BaseURL = Config.manager.URL_GATEWAY!
			default:
				BaseURL = "http://mposapibeta.fptshop.com.vn:2017"
		}

		switch self {
			case .addOrder:
				return BaseURL + "/api/Sim/VinaAddOrder_SMCS"
			case .getOrder(let id):
				return BaseURL +   "/api/Sim/VinaGetOrderChuoiStatus_SMCS?Usercode=\(Cache.user!.UserName)&Shopcode=\(Cache.user!.ShopCode)&Idvinaphone=\(id)"
			case .getListActiveSim(let type):
				return BaseURL +   "/api/Sim/mpos_FRT_ActiveSim_GetList?userid=\(Cache.user!.UserName)&shopcode=\(Cache.user!.ShopCode)&type=\(type)&provider=Vinaphone"
		}
	}

	var parameters: JSONDictionary {
		switch self {
			case .addOrder(let param):
				return [
					"Usercode": param.Usercode ?? "",
					"Shopcode": param.Shopcode ?? "",
					"PhoneNumber": param.PhoneNumber ?? "",
					"Serial": param.Serial ?? "",
					"CMND": param.CMND ?? "",
					"FullName": param.FullName ?? "",
					"PackageCode": param.PackageCode ?? "",
					"PackageName": param.PackageName ?? "",
					"PackagePrice": param.PackagePrice ?? "",
					"PackageType": param.PackageType ?? 0
				]
			case .getOrder:
				return [:]
			case .getListActiveSim:
				return [:]
		}
	}
}
