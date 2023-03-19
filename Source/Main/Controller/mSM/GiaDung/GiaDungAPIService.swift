//
//  GiaDungAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 24/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GiaDungAPIServiceProtocol {
    func getGiaDungData(type: GiaDungType,pType: Int, success: @escaping SuccessHandler<GiaDungRealtime>.object, failure: @escaping RequestFailure)
}

class GiaDungAPIService: GiaDungAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getGiaDungData(type: GiaDungType,pType: Int,success: @escaping SuccessHandler<GiaDungRealtime>.object, failure: @escaping RequestFailure) {
        let endPoint = GiaDungEndPoint.getGiaDungData(type: type, pType: pType)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
