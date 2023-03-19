//
//  LapRapPCEnpoint.swift
//  fptshop
//
//  Created by Sang Truong on 10/8/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum LapRapPCEndPoint {
    case getListPC(shopCode:String,status: String,from: String,to:String,itemCode:String)
    case getListLinhKien(itemCode:String,doc_request:String,doc_header:String)
    case updateStateOrder(doc_request:String,doc_header:String,status:String,update_by_code:String,update_by_name:String)
    case insertOrderBuildPC(doc_request:String,doc_header:String,update_by_code:String,update_by_name:String,detail:[[String:Any]])
    case uploadImagePC(base64:String,folder:String,filename:String)
    case saveImagePC(userCode:String,shopCode:String,docEntry:String,fileName:String)
}

extension LapRapPCEndPoint: EndPointType {
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
            return BASE_URL + "/promotion-service/api/BuildPC/ListLinhKienByItemCodePC"
        case .updateStateOrder:
            return BASE_URL + "/promotion-service/api/BuildPC/UpdateTrangThaiPhieuLapRap"
        case .insertOrderBuildPC:
            return BASE_URL + "/promotion-service/api/BuildPC/InsertChiTietPhieuLapRap"
        case .uploadImagePC:
            return BASE_URL + "/mpos-cloud-api/api/Upload/file"
        case .saveImagePC:
            return BASE_URL + "/mpos-cloud-api/api/Upload/Mpos_FRT_SaveUploadImage_LapRapPC"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListPC(let shopCode, let status,let from,let to,let itemCode):
            return [
                "shopCode": shopCode,
                "status": status,
                "dateFrom": from,
                "dateTo": to,
                "itemCode": itemCode
            ]
        case .getListLinhKien(let itemCode,let doc_request,let doc_header):
            return [
                "itemCode_PC": itemCode,
                "docEntry_Header" : doc_header,
                "docEntry_Request" : doc_request
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
        case .uploadImagePC(let base64,let folder,let  filename):
            return [
                "base64": base64,
                "folder": folder,
                "filename": filename,
            ]
        case .saveImagePC(let userCode,let shopCode,let docEntry,let fileName):
            return [
                "UserCode": userCode,
                "ShopCode": shopCode,
                "DocEntry": docEntry,
                "FileName": fileName
            ]
        }
    }
}
