//
//  RaPCEndPoint.swift
//  fptshop
//
//  Created by Sang Truong on 12/1/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

enum RaPCEndPoint {
    case getListPC(shopCode:String,status: String,from: String,to:String,itemCode:String,requestType:String)
    case getListLinhKien(itemCode:String,doc_request:String,doc_header:String)
    case getDetailsImei(itemCode:String,imei:String)
    case updateStateOrder(doc_request:String,doc_header:String,status:String,update_by_code:String,update_by_name:String)
    case insertOrderBuildPC(doc_request:String,doc_header:String,update_by_code:String,update_by_name:String,detail:[[String:Any]])
    
}

extension RaPCEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        
        switch self {
        case .getListPC:
            return BASE_URL + "/promotion-service/api/BuildPC/ListLinhKienBySearch"
        case .getListLinhKien:
            return BASE_URL + "/promotion-service/api/BuildPC/GetPhieuRaPCDetail"
        case .getDetailsImei:
            return BASE_URL + "/promotion-service/api/BuildPC/ListLinhKienByImeiPC"
        case .updateStateOrder:
            return BASE_URL + "/promotion-service/api/BuildPC/UpdateTrangThaiPhieuRaPC"
        case .insertOrderBuildPC:
            return BASE_URL + "/promotion-service/api/BuildPC/InsertChiTietPhieuRaPC"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListPC(let shopCode, let status,let from,let to,let itemCode, let requestType):
            return [
                "shopCode": shopCode,
                "status": status,
                "dateFrom": from,
                "dateTo": to,
                "itemCode": itemCode,
                "requestType": requestType

            ]
        case .getListLinhKien(let itemCode,let doc_request,let doc_header):
            return [
                "itemCode_PC": itemCode,
                "docEntry_Header" : doc_header,
                "docEntry_Request" : doc_request
            ]
        case .getDetailsImei(let itemCode,let imei):
            return [
                "itemCode_PC": itemCode,
                "imei" : imei
            ]
        case .updateStateOrder(let doc_request,let  doc_header,let  status,let  update_by_code,let  update_by_name):
            return [
                "docEntry_Request": doc_request,
                "docEntry_Header": doc_header,
                "status": status,
                "update_By_Code": update_by_code,
                "update_By_Name": update_by_name
            ]
        case .insertOrderBuildPC(let doc_request,let  doc_header,let  update_by_code,let  update_by_name,let  detail):
            return [
                "docEntry_Request": doc_request,
                "docEntry_Header": doc_header,
                "update_By_Code": update_by_code,
                "update_By_Name": update_by_name,
                "detail": detail
            ]
        }
    }
}
