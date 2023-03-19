//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Alamofire
import Foundation

enum EbayEndpoint {
	case getListFinacial
	case getFeeEbay(financialCode: String, contractNo: String, customerIdNo: String, address: String)
	case uploadImageEbay(ma_hop_dong: String, type: Int, base64: String)
	case genBienLaiEbay(
		ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
		ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
		ten_thu_ngan: String, chu_ky_dien_tu: String, don_vi_tai_chinh: String)
	case saveOrderEbay(
		orderStatus: Int,
		orderStatusDisplay: String,
		billNo: String,
		customerId: String,
		customerName: String,
		customerPhoneNumber: String,
		warehouseCode: String,
		regionCode: String,
		creationBy: String,
		creationTime: String,
		referenceSystem: String,
		referenceValue: String,
		orderTransactionDtos: [[String: Any]],
		payments: [[String: Any]],
		id: String,
		ip: String)
	case updateBienLai(orderId: String, url: String)
	case checkTransaction(ProviderId: String, OrderId: String, ProductId: String)
	case checkTransactionNew(OrderId: String)
	case searchContractSeason1(
		providerId: String, customerId: String, integratedGroupCode: String, integratedProductCode: String,
		pin: String)
	case searchContractSeason2(
		providerId: String, customerId: String, integratedGroupCode: String, integratedProductCode: String,
		pin: String)
}

extension EbayEndpoint: EndPointType {

	var headers: HTTPHeaders? {
		switch self {
		case .getFeeEbay:
			return DefaultHeader().addAuthHeaderEbay()
		default:
			return DefaultHeader().addAuthHeader()
		}
	}

	var path: String {
		var urlUploadImage = ""
		var urlGenBienLai = ""
		let target = Bundle.main.infoDictionary?["TargetName"] as? String
		let BASE_URL = Config.manager.URL_GATEWAY!
		switch target {
		case "fptshop", "Production":
			urlUploadImage = Config.manager.URL_GATEWAY! + "/mpos-cloud-api/api/Epay/UploadImage"
			urlGenBienLai = Config.manager.URL_GATEWAY! + "/mpos-cloud-api/api/Epay/GenImage_BienLaiChiTien"
		default:  // beta
			urlUploadImage = "http://mposapibeta.fptshop.com.vn:2017/api/Epay/UploadImage"
			urlGenBienLai = "http://mposapibeta.fptshop.com.vn:2017/api/Epay/GenImage_BienLaiChiTien"
		}
		switch self {
		case .getListFinacial:
			return BASE_URL + "/som-product-service/api/Product/v1/Products/financial"
		case .getFeeEbay:
			return BASE_URL + "/som-integration-service/api/integration/v1/epay/get-fee"
		case .uploadImageEbay:
			return urlUploadImage
		case .genBienLaiEbay:
			return urlGenBienLai
		case .saveOrderEbay:
			return BASE_URL + "/som-order-service/api/Order/v1/order"
		case .updateBienLai:
			return BASE_URL
				+ "/som-search-service/api/Search/v1/Order/UpdateSignature"
		case .checkTransaction:
			return BASE_URL
				+ "/som-integration-service/api/integration/v1/order/6ad92719-2b9e-5bd3-0931-3a04dafa274a%09/client-status"
		case .checkTransactionNew:
			return BASE_URL
				+ "/som-order-service/api/Order/v1/order/status"
		case .searchContractSeason1(let providerId, let customerId, let integratedGroupCode, let integratedProductCode, let pin):
			return BASE_URL
				+ "/som-integration-service/api/integration/v1/customerv2?ProviderId=\(providerId)&CustomerId=\(customerId)&integratedGroupCode=\(integratedGroupCode)&integratedProductCode=\(integratedProductCode)&pin=\(pin)"
		case .searchContractSeason2(let providerId, let customerId, let integratedGroupCode, let integratedProductCode, let pin):
			return BASE_URL
				+ "/som-integration-service/api/integration/v1/customerv2?ProviderId=\(providerId)&CustomerId=\(customerId)&integratedGroupCode=\(integratedGroupCode)&integratedProductCode=\(integratedProductCode)&pin=\(pin)"
		}
	}

	var httpMethod: HTTPMethod {
		switch self {
		case .getFeeEbay, .saveOrderEbay, .uploadImageEbay, .genBienLaiEbay:
			return .post
			case .getListFinacial, .updateBienLai, .checkTransaction, .checkTransactionNew,.searchContractSeason1,.searchContractSeason2:
			return .get

		}
	}

	var parameters: JSONDictionary {
		switch self {
		case .getListFinacial:
			return [:]
		case .uploadImageEbay(let ma_hop_dong, let type, let base64):
			return [
				"ma_hop_dong": ma_hop_dong,
				"type": type,
				"base64": base64,
			]
		case .genBienLaiEbay(
			let ten_shop, let dia_chi_shop, let ngay_tao, let ma_giao_dich, let khach_hang, let ma_hop_dong,
			let so_tien_nhan, let so_dien_thoai, let ma_thu_ngan, let ten_thu_ngan, let chu_ky_dien_tu,
			let don_vi_tai_chinh):
			return [
				"ten_shop": ten_shop,
				"dia_chi_shop": dia_chi_shop,
				"ngay_tao": ngay_tao,
				"ma_giao_dich": ma_giao_dich,
				"khach_hang": khach_hang,
				"ma_hop_dong": ma_hop_dong,
				"so_tien_nhan": so_tien_nhan,
				"so_dien_thoai": so_dien_thoai,
				"ma_thu_ngan": ma_thu_ngan,
				"ten_thu_ngan": ten_thu_ngan,
				"chu_ky_dien_tu": chu_ky_dien_tu,
				"don_vi_tai_chinh": don_vi_tai_chinh,
			]
		case .getFeeEbay(let financialCode, let contractNo, let customerIdNo, let address):
			return [
				"financialCode": financialCode,
				"contractNo": contractNo,
				"customerIdNo": customerIdNo,
				"address": address,
			]
		case .saveOrderEbay(
			let orderStatus,
			let orderStatusDisplay,
			let billNo,
			let customerId,
			let customerName,
			let customerPhoneNumber,
			let warehouseCode,
			let regionCode,
			let creationBy,
			let creationTime,
			let referenceSystem,
			let referenceValue,
			let orderTransactionDtos,
			let payments,
			let id,
			let ip):
			return [
				"orderStatus": orderStatus,
				"orderStatusDisplay": orderStatusDisplay,
				"billNo": billNo,
				"customerId": customerId,
				"customerName": customerName,
				"customerPhoneNumber": customerPhoneNumber,
				"warehouseCode": warehouseCode,
				"regionCode": regionCode,
				"creationBy": creationBy,
				"creationTime": creationTime,
				"referenceSystem": referenceSystem,
				"referenceValue": referenceValue,
				"orderTransactionDtos": orderTransactionDtos,
				"payments": payments,
				"id": id,
				"ip": ip,
			]
		case .updateBienLai(let orderId, let url):
			return [
				"orderId": orderId,
				"url": url,
			]
		case .checkTransaction(let ProviderId, let OrderId, let ProductId):
			return [
				"ProviderId": ProviderId,
				"OrderId": OrderId,
				"ProductId": ProductId,
			]
		case .checkTransactionNew(let OrderId):
			return [
				"OrderId": OrderId
			]
			case .searchContractSeason1:
				return [:]
			case .searchContractSeason2:
				return [:]
		}
	}
}
