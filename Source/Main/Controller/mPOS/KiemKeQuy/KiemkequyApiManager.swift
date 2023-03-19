//
//  KiemkequyApiManager.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

class KiemkequyApiManager {
    static let shared = KiemkequyApiManager()
    var provider: MoyaProvider<KiemkequyApiService> = MoyaProvider<KiemkequyApiService>(plugins: [VerbosePlugin(verbose: true)])

    func getTotalFund(shopCode: String ,completion: @escaping ((TongQuyItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["shop_Code"] = shopCode
        provider.request(.getTongquy(params: params )) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = TongQuyItem.getObjFromDictionary(map: json)
                    if rs.message?.message_Code != 200 {
                        completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                    } else {
                        completion(rs,"")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func saveCheckFund(shopItem: ItemShop,isNormal: Bool,doc_Status: String,totalFund: Double,detail:[[String: Any]],completion: @escaping ((SaveKiemkeItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["shop_Code"] = shopItem.code
        params["shop_Name"] = shopItem.needFullName ? shopItem.fullName : shopItem.name
        params["doc_Type"] = isNormal ? "1" : "2"
        params["doc_Type_Name"] = isNormal ? "KK thường" : "KK cuối ngày"
        params["doc_Type_Name"] = isNormal ? "KK thường" : "KK cuối ngày"
        params["doc_Status"] = doc_Status
        params["so_Tien_Kiem_Quy"] = totalFund
        params["update_By_Code"] = Cache.user?.UserName
        params["update_By_Name"] = Cache.user?.EmployeeName
        params["detail"] = detail
        
        provider.request(.saveKiemke(params: params )) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let statusCode = response.statusCode
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    if (200...299).contains(statusCode) {
                        let rs = SaveKiemkeItem.getObjFromDictionary(map: json)
                        if rs.message?.message_Code != 200 {
                            completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                        } else {
                            completion(rs,"")
                        }
                    } else {
                        completion(nil,"\(json["message"].description)")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }

    func saveGiaiTrinh(docentry: Int,detail:[[String: Any]],completion: @escaping ((SaveKiemkeItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["docentry"] = docentry
        params["create_By_Code"] = Cache.user?.UserName
        params["create_By_Name"] = Cache.user?.EmployeeName
        params["detail"] = detail
        provider.request(.saveGiaiTrinh(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                let statusCode = response.statusCode
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = SaveKiemkeItem.getObjFromDictionary(map: json)
                    if (200...299).contains(statusCode) {
                        if rs.message?.message_Code != 200 {
                            completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                        } else {
                            completion(rs,"")
                        }
                    } else {
                        completion(nil,"\(json["message"].description)")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getDetailKiemKe(docentry: Int,completion: @escaping ((KiemKeItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["docentry"] = docentry
        params["user_Login"] = Cache.user!.UserName
        provider.request(.getListDetail(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = KiemKeItem.getObjFromDictionary(map: json)
                    if rs.message?.message_Code != 200 {
                        completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                    } else {
                        completion(rs,"")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getSearchKiemke(docentry: Int?,from: String,to:String,shopCode:String,status:String,completion: @escaping ((SearchKiemkeItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["docentry"] = docentry == nil ? -5 : docentry
        params["date_From"] = from
        params["date_To"] = to
        params["shop_Code"] = shopCode
        params["doc_Status"] = status
        provider.request(.searchListKiemke(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = SearchKiemkeItem.getObjFromDictionary(map: json)
                    if rs.message?.message_Code != 200 {
                        completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                    } else {
                        completion(rs,"")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func updateHeaderState(docentry: Int,status: String,completion: @escaping ((SaveKiemkeItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["docentry"] = docentry
        params["update_By_Code"] = Cache.user?.UserName
        params["update_By_Name"] = Cache.user?.EmployeeName
        params["doc_Status"] = status
        
        provider.request(.updateKiemKeQuy(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    print("return value: \(json)")
                    let rs = SaveKiemkeItem.getObjFromDictionary(map: json)
                    if rs.message?.message_Code != 200 {
                        completion(nil,rs.message?.message_Desc ?? "Đã xảy ra lỗi \(rs.message?.message_Code ?? 0)")
                    } else {
                        completion(rs,"")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
}

enum KiemkequyApiService {
    case getTongquy(params: [String: Any])
    case saveKiemke(params: [String: Any])
    case saveGiaiTrinh(params: [String: Any])
    case getListDetail(params: [String: Any])
    case searchListKiemke(params: [String: Any])
    case updateKiemKeQuy(params: [String: Any])
}

extension KiemkequyApiService: TargetType {
    var path: String {
        switch self {
        case .getTongquy:
            return "/promotion-service/api/FundInventory/GetTongSoTienQuyHeThong"
        case .saveKiemke:
            return "/promotion-service/api/FundInventory/InsertKiemKeQuy"
        case .saveGiaiTrinh:
            return "/promotion-service/api/FundInventory/InsertKiemKeQuyGiaiTrinh"
        case .getListDetail:
            return "/promotion-service/api/FundInventory/ListKiemKeQuyChiTiet"
        case .searchListKiemke:
            return "/promotion-service/api/FundInventory/ListKiemKeQuySearch"
        case .updateKiemKeQuy:
            return "/promotion-service/api/FundInventory/UpdateKiemKeQuyHeader"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getTongquy(let params),.saveKiemke(let params),.saveGiaiTrinh(let params),.getListDetail(let params),.searchListKiemke(let params),.updateKiemKeQuy(let params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json",
                "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")"
        ]
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: Config.manager.URL_GATEWAY ?? "") else {
            fatalError("Could not get url")
        }
        return url
    }
}
