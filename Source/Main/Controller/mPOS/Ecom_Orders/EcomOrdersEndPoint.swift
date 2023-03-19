//
//  EcomOrdersEndPoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum EcomOrdersEndPoint {
    case loadListEcomOrders(user: String,shopcode: String,type: String)
    case wirteLog(user: String,shopCode: String,ecomNum: Int)
    case loadListEmployees(user: String, shopCode: String)
    case phanconNV(user:String, shopCode:String,ecomNum: Int,sale: String,typeAssignment:String)
    case getEmployByEcom(ecomNum: Int)
    case confirmSale(ecomNum:Int,status: Int,comment:String,timeDelivery:String,addressdelivery:String,tinh:String,huyen:String,xa:String)
    case setSoDelivering(docNum: String, user: String, pass: String)
    case getEcomOrderDetails(docNum: String)
    case getEcomOderTinh
    case getEcomOderQuanHuyen(tinhThanhPhoID:String)
    case getEcomOderPhuongXa(quanHuyenID:String)
}

extension EcomOrdersEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case    .loadListEcomOrders,
                .loadListEmployees,
                .getEmployByEcom,
                .getEcomOrderDetails,
                .getEcomOderTinh,
                .getEcomOderQuanHuyen,
                .getEcomOderPhuongXa:
            return .get
        default:
            return .post
        }
    }
    
    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        switch self {
        case .loadListEcomOrders(let user,let shopcode,let type):
            return BASE_URL + "/internal-api-service/api/mpos/get-ecom-next-pos?userid=\(user)&shopcode=\(shopcode)&type=\(type)"
        case .loadListEmployees(let user,let shopCode):
            return BASE_URL + "/internal-api-service/api/mpos/get-employee-by-shop?userid=\(user)&shopcode=\(shopCode)"
        case .getEmployByEcom(let ecomNum):
            return BASE_URL + "/internal-api-service/api/mpos/get-employees-by-ecomnum?ecomnum=\(ecomNum)"
        case .wirteLog:
            return BASE_URL + "/internal-api-service/api/mpos/ecom-next-pos-call"
        case .phanconNV:
            return BASE_URL + "/internal-api-service/api/mpos/assign-sale-employee"
        case .confirmSale:
            return BASE_URL + "/internal-api-service/api/mpos/ecom-next-pos-confirm-call"
        case .setSoDelivering(let docNum, let user, let pass):
            let passEncoded = pass.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            return URLs.MDELIVERY_SERVICE_ADDRESS_GATEWAY + "/api/Delivery/setSODelivering?docNum=\(docNum)&userCode=\(user)&password=\(passEncoded)"
        case .getEcomOrderDetails(let docNum):
            return BASE_URL + "/internal-api-service/api/mpos/get-detailsOrder-by-ecomnum?ecomnum=\(docNum)"
        case .getEcomOderTinh:
            return BASE_URL + "/internal-api-service/api/mpos/getprovince-ecom-next-pos"
        case .getEcomOderQuanHuyen(let tinhThanhPhoID):
            print(BASE_URL + "/internal-api-service/api/mpos/getdistrict-ecom-next-pos?CityID=\(tinhThanhPhoID)")
            return BASE_URL + "/internal-api-service/api/mpos/getdistrict-ecom-next-pos?CityID=\(tinhThanhPhoID)"
        case .getEcomOderPhuongXa(let quanHuyenID):
            return BASE_URL + "/internal-api-service/api/mpos/getWards-ecom-next-pos?QuanHuyenID=\(quanHuyenID)"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .wirteLog(let user,let shopCode,let ecomNum):
            return [
                "userid": user,
                "shopcode": shopCode,
                "ecomnum": ecomNum
            ]
        case .phanconNV(let user,let shopCode,let ecomNum,let sale, let typeAssignment):
            return [
                "userid": user,
                "shopcode": shopCode,
                "ecomnum": ecomNum,
                "sales": sale,
                "typeAssignment":typeAssignment
            ]
        case .confirmSale(let ecomNum,let status,let comment,let timeDelivery,let addressDelivery,let tinh, let huyen, let xa):
            return [
                "userid": Cache.user!.UserName,
                "shopcode": Cache.user!.ShopCode,
                "ecomnum": ecomNum,
                "p_status_call": 0,
                "p_comment": "",
                "p_timeDelivery": timeDelivery,
                "p_addressdelivery": addressDelivery,
                "p_Tinh":tinh,
                "p_Huyen":huyen,
                "p_Xa":xa
            ]
        case .setSoDelivering(let docNum, let user, let pass):
            return [:]
        case .getEcomOrderDetails:
            return [:]
        case .getEcomOderTinh:
            return [:]
        case .getEcomOderPhuongXa:
            return [:]
        case .getEcomOderQuanHuyen:
            return [:]
        default:
            return [:]
        }
    }
}
