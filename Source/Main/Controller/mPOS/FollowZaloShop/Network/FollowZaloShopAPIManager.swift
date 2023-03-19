//
//  FollowZaloShopAPIManager.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

fileprivate protocol FollowZaloShopAPIManagerProtocol {
    func getListCustomerFollow(_ shopCode: String, completion: @escaping ([ListCustomerFollowZaloModel]?) -> Void, failure: @escaping (String?) -> Void)
    
    func verify_QRCode_Zalo_Customer(_ qrCode: String, completion: @escaping(ScannerVerifyQRCodeZaloModel?) -> Void, failure: @escaping (String?) -> Void)
    
    func update_info_customer_follow_zalo_shop(_ params: [String:Any], completion: @escaping(UpdateSuccessCustomerFollowZaloModel?) -> Void, failure: @escaping(String?) -> Void)
}

class FollowZaloShopAPIManager: FollowZaloShopAPIManagerProtocol {
    
    static let shared = FollowZaloShopAPIManager()
    let decoder = JSONDecoder()
    var provider: MoyaProvider<FollowZaloShopAPIService> = MoyaProvider<FollowZaloShopAPIService>(plugins: [VerbosePlugin(verbose: true)])
    
    func getListCustomerFollow(_ shopCode: String, completion: @escaping ([ListCustomerFollowZaloModel]?) -> Void, failure: @escaping (String?) -> Void) {
        provider.request(.getListCustomer(shopCode)) { [weak self](result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let listItem = try strongSelf.decoder.decode([ListCustomerFollowZaloModel].self, from: response.data)
                        if !listItem.isEmpty {
                            completion(listItem)
                        } else {
                            failure("Không có dữ liệu nào, vui lòng kiểm tra lại")
                        }
                    case .failure(let error):
                        failure(error)
                    }
                } catch let err {
                    failure(err.localizedDescription)
                }
            case let .failure(err):
                failure(err.localizedDescription)
            }
        }
    }
    
    func verify_QRCode_Zalo_Customer(_ qrCode: String, completion: @escaping (ScannerVerifyQRCodeZaloModel?) -> Void, failure: @escaping (String?) -> Void) {
        provider.request(.verify_ScanQR_Code_Zalo(qrCode)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let resultItem = try strongSelf.decoder.decode(ScannerVerifyQRCodeZaloModel.self, from: response.data)
                        completion(resultItem)
                    case .failure(let error):
                        failure(error)
                    }
                } catch let error {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func update_info_customer_follow_zalo_shop(_ params: [String : Any], completion: @escaping (UpdateSuccessCustomerFollowZaloModel?) -> Void, failure: @escaping (String?) -> Void) {
        provider.request(.update_info_customer_follow_zalo(params)) { [weak self](result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let item = try strongSelf.decoder.decode(UpdateSuccessCustomerFollowZaloModel.self, from: response.data)
                        completion(item)
                    case .failure(let error):
                        failure(error)
                    }
                } catch let error {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
}
