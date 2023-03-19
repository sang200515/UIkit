//
//  HangHotApiService.swift
//  fptshop
//
//  Created by Ngoc Bao on 29/09/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol HangHotApiserviceProtocol {
    func getHangHotData(type: HangHotType,success: @escaping SuccessHandler<HangHotRealtime>.object, failure: @escaping RequestFailure)
}

class HangHotApiService: HangHotApiserviceProtocol {
    func getHangHotData(type: HangHotType,success: @escaping SuccessHandler<HangHotRealtime>.object, failure: @escaping RequestFailure) {
        let endPoint = HangHotEndPoint.getHangHotData(type: type)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    

}
