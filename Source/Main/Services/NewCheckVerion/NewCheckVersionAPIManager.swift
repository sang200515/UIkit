//
//  NewCheckVersionAPIManager.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

fileprivate protocol NewCheckVersionAPIManagerProtocol {
    func newCheckVersion(_ params: [String:Any], completion: @escaping(_ results: NewCheckVersionModelDatum?, _ err: String?) -> Void)
}

class NewCheckVersionAPIManager: NewCheckVersionAPIManagerProtocol {
    
    static let shared = NewCheckVersionAPIManager()
    var provider: MoyaProvider<NewCheckVersionAPIService> = MoyaProvider<NewCheckVersionAPIService>( plugins: [VerbosePlugin(verbose: true)])
    let decoder = JSONDecoder()
    
    func newCheckVersion(_ params: [String : Any], completion: @escaping (NewCheckVersionModelDatum?, String?) -> Void) {
        provider.request(.newCheckVersion(params)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResult = Common.handleNetworkResponse(response)
                    switch myResult {
                    case .success:
                        let newCheckVersionItem = try strongSelf.decoder.decode(NewCheckVersionModelRoot.self, from: response.data)
                        printLog(function: #function, json: newCheckVersionItem)
                        if let success  = newCheckVersionItem.success {
                            if success {
                                if let items = newCheckVersionItem.data {
                                    completion(items, nil)
                                }
                            } else {
                                completion(nil, "Kiểm tra lại phiên bản")
                            }
                        }
                    case .failure(let err):
                        completion(nil, err)
                    }
                } catch let err {
                    printLog(function: #function, json: err.localizedDescription)
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
}


