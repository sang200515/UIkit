//
//  GuaranteeAutoApiManager.swift
//  fptshop
//
//  Created by Ngoc Bao on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

class GuaranteeAutoApiManager {
    
    
    static let shared = GuaranteeAutoApiManager()
    var provider: MoyaProvider<GuaranteeAutoService> = MoyaProvider<GuaranteeAutoService>( plugins: [VerbosePlugin(verbose: true)])
    let decoder = JSONDecoder()
    
    func getListGRT(completion: @escaping (([GRTHistoryItem], String) -> Void)) {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let current = formatter.string(from: currentDateTime)
        var params = [String: Any]()
        params["soPhieuBH"] = 0
        params["shopCode"] = Cache.user?.ShopCode
        params["fromDate"] = current
        params["toDate"] = current
        provider.request(.LoadThongTinTestMay_Mobile(params: params)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = GRTHistoryItem.parseObjfromArray(array: json.arrayValue)
                    var err = ""
                    err  = json["error"]["message"].description
                    if rs.count > 0 {
                        completion(rs,"")
                    } else {
                        if err != "" && err.lowercased() != "null" {
                            completion([],err)
                        } else {
                            completion([],"")
                        }
                    }
                } catch let err {
                    completion([], err.localizedDescription)
                }
            case let .failure(err):
                completion([], err.localizedDescription)
            }
        }
    }
    
    func getListHistoryGRT(sophieuBH: Int, fromdate: String, todate: String, state: Int,completion: @escaping (([GRTHistoryItem], String) -> Void)) {
        var params = [String: Any]()
        params["soPhieuBH"] = sophieuBH
        params["shopCode"] = Cache.user?.ShopCode
        params["trangThaiTest"] = state
        params["fromDate"] = "01/01/2020"
        params["toDate"] = "01/12/2021"
        provider.request(.LoadLichSuTestMay_Mobile(params: params)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = GRTHistoryItem.parseObjfromArray(array: json.arrayValue)
                    var err = ""
                    err  = json["error"]["message"].description
                    if rs.count > 0 {
                        completion(rs,"")
                    } else {
                        if err != "" {
                            completion([],err)
                        } else {
                            completion([],"")
                        }
                    }
                } catch let err {
                    completion([], err.localizedDescription)
                }
            case let .failure(err):
                completion([], err.localizedDescription)
            }
        }
    }
    
    func saveDeleteTest(grtItem: GRTHistoryItem ,isOK: Bool,completion: @escaping ((GRTSaveDeleteItem?, String) -> Void)) {
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let current = formatter.string(from: currentDateTime)
        var params = [String: Any]()
        params["loaisp"] = "L"
        params["soPhien"] = 0
        params["idNguoiTest"] = Cache.user?.Id
        params["tenNguoiTest"] = Cache.user?.EmployeeName
        params["chucDanhNguoiTest_Ten"] = Cache.user?.JobTitleName
        params["chucDanhNguoiTest_Ma"] = Cache.user?.JobTitle
        params["phongBan_Ma"] = Cache.user?.ShopCode
        params["phongBan_Ten"] = Cache.user?.ShopName
        var itemTest = [[String: Any]]()
        var item = [String: Any]()
        item["maPhieuBH"] = grtItem.maPhieuBH
        item["ketQuaTest_Ma"] = isOK ? 2 : 1
        item["ketQuaTest_Ten"] = isOK ? "OK" : "NotOK"
        item["moTaLoi"] = grtItem.moTaLoi
        item["trangThaiTest"] = 2
        item["nguoiTao"] = Cache.user?.Id
        item["nguoiCapNhat"] = 0
        item["trangThai"] = 1
        item["ngayTao"] = current + ".000Z"
        item["ngayCapNhat"] = current + ".000Z"
        itemTest.append(item)
        params["tB_LichSuTestMay"] = itemTest
        provider.request(.Luu_XoaTestMay(params: params)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = GRTSaveDeleteItem.getObjFromDictionary(data: json.arrayValue.first ?? json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
}
