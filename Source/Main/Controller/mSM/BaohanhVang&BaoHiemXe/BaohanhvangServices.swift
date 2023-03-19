//
//  BaohanhvangServices.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol BaoHanhApiserviceProtocol {
    func getBaoHanhVang(type: BaoHanhType,success: @escaping SuccessHandler<BaoHanhVang>.object, failure: @escaping RequestFailure)
    func getBaoHiemXe(type: BaoHanhType,success: @escaping SuccessHandler<BaoHiemXeMay>.object, failure: @escaping RequestFailure)
}

class BaoHanhApiservice: BaoHanhApiserviceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getBaoHanhVang(type: BaoHanhType,success: @escaping SuccessHandler<BaoHanhVang>.object, failure: @escaping RequestFailure) {
        let endPoint = BaohanhEnpoint.getBaoHanhVang(type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBaoHiemXe(type: BaoHanhType,success: @escaping SuccessHandler<BaoHiemXeMay>.object, failure: @escaping RequestFailure) {
        let endPoint = BaohanhEnpoint.getBaoHiemXe(type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
