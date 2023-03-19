//
//  ReplacementAccessoriesAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ReplacementAccessoriesAPIServiceProtocol {
    func getReplacementAccessories(sku: String, success: @escaping ((ReplacementAccessory, String) -> Void), failure: @escaping RequestFailure)
}

class ReplacementAccessoriesAPIService: ReplacementAccessoriesAPIServiceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getReplacementAccessories(sku: String, success: @escaping ((ReplacementAccessory, String) -> Void), failure: @escaping RequestFailure) {
        let endPoint = ReplacementAccessoriesEndPoint.getReplacementAccessories(sku: sku)
        network.requestData(endPoint: endPoint, success: { data in
            let json = JSON(data)
            var rs: ReplacementAccessory = ReplacementAccessory(sku: "", text: "", variants: [])
            var label: String = ""
            if let array = json["data"].array {
                rs = ReplacementAccessory.getObjFromDictionary(data: array[0]["product_bundled"])
                label = array[0]["label"].stringValue
            }
            
            success(rs, label)
        }, failure: failure)
    }
}
