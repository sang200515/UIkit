//
//  CMSNAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CMSNAPIServiceProtocol {
    func getCMSNHistories(success: @escaping SuccessHandler<CMSNHistory>.object, failure: @escaping RequestFailure)
    func cancelCMSNVoucher(id: Int, success: @escaping SuccessHandler<CMSNResponse>.object, failure: @escaping RequestFailure)
}

class CMSNAPIService: CMSNAPIServiceProtocol {
    
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getCMSNHistories(success: @escaping SuccessHandler<CMSNHistory>.object, failure: @escaping RequestFailure) {
        let endPoint = CMSNEndPoint.getCMSNHistories
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func cancelCMSNVoucher(id: Int, success: @escaping SuccessHandler<CMSNResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = CMSNEndPoint.cancelCMSNVoucher(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
