//
//  UserviceAPIManager.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

fileprivate protocol UserviceAPIManagerProtocol {
    var provider: MoyaProvider<UserviceAPIServices> { get }
    func getListGroupFeatures(completion: @escaping([ListFeatureItemPDatum]) -> Void, failure: @escaping(String) -> Void)
    func createTicketIPItem(params: [String:Any], completion: @escaping(String) -> Void, failure: @escaping(String) -> Void)
    func uploadFileImage(params: [String:Any], completion: @escaping(_ item: ResponseItemUploadImageFile.PData, _ msg: String ) -> Void, failure: @escaping(String) -> Void)
    func getListHistoryUservice(params: [String:Any], completion: @escaping (_ item: [HistoryUserviceTickeData], _ msg: String?) -> Void, failure: @escaping(String) -> Void)
}

class UserviceAPIManager: UserviceAPIManagerProtocol {
    
    static let shared = UserviceAPIManager()
    let decoder = JSONDecoder()
    
    var provider: MoyaProvider<UserviceAPIServices> = MoyaProvider<UserviceAPIServices>(plugins: [VerbosePlugin(verbose: true)])
    
    func getListGroupFeatures(completion: @escaping ([ListFeatureItemPDatum]) -> Void, failure: @escaping (String) -> Void) {
        let params: [String:Any] = ["FromSystem" : "mPOS"]
        provider.request(.getListGroupFeature(params)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResult = Common.handleNetworkResponse(response)
                    switch myResult {
                    case .success:
                        let listGroupFeatureItem = try strongSelf.decoder.decode([ListFeatureItemPDatum].self, from: response.data)
                            if listGroupFeatureItem.count > 0 {
                                completion(listGroupFeatureItem)
                            } else {
                                failure("Không có dữ liệu danh sách nhóm chức năng")
                            }
                    case .failure(let err):
                        failure(err)
                    }
                } catch let error {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func createTicketIPItem(params: [String : Any], completion: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.createTicketUservice(params)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            
            switch result {
            case let .success(response):
                do {
                    let myResult = Common.handleNetworkResponse(response)
                    switch myResult {
                    case .success:
                        let responseCreate = try strongSelf.decoder.decode(CreateTicketResponseItem.self, from: response.data)
                        if responseCreate.pStatus == 0 {
                            completion(responseCreate.pMessages ?? "")
                        } else {
                            if responseCreate.pMessages?.isEmpty ?? false {
                                completion("Tạo phiếu không thành công")
                            } else {
                                completion(responseCreate.pMessages ?? "")
                            }
                        }
                    case .failure(let err):
                        failure(err)
                    }
                } catch let error {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func uploadFileImage(params: [String : Any], completion: @escaping (ResponseItemUploadImageFile.PData, String) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.uploadImageFile(params)) { [weak self](result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResult = Common.handleNetworkResponse(response)
                    switch myResult {
                    case .success:
                        let responseUpload = try strongSelf.decoder.decode(ResponseItemUploadImageFile.self, from: response.data)
                        if responseUpload.pStatus == 0 {
                            if let item = responseUpload.pData, let msg = responseUpload.pMessages {
                                completion(item, msg)
                            }
                        } else {
                            if let msg = responseUpload.pMessages {
                                failure(msg)
                            }
                        }
                    case .failure(let err):
                        failure(err)
                    }
                    
                } catch let error {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
    
    func getListHistoryUservice(params: [String : Any], completion: @escaping ([HistoryUserviceTickeData], String?) -> Void, failure: @escaping (String) -> Void) {
        
        provider.request(.getListHistoryUservice(params)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResult = Common.handleNetworkResponse(response)
                    switch myResult {
                    case .success:
                        let responseItem = try strongSelf.decoder.decode([HistoryUserviceTickeData].self, from: response.data)
                        if responseItem.count > 0 {
                            completion(responseItem, nil)
                        } else {
                            failure("Không có dữ liệu")
                        }
                    case .failure(let err):
                        failure(err)
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


