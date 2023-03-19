//
//  CheckListSMApiService.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CheckListSMApiServiceProtocol {
    func getData(success: @escaping SuccessHandler<ListSMModel>.object, failure: @escaping RequestFailure)
    func confirm(id: Int,success: @escaping SuccessHandler<ComfimSMModel>.object, failure: @escaping RequestFailure)
}

class CheckListSMApiService: CheckListSMApiServiceProtocol {
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    

    func getData(success: @escaping SuccessHandler<ListSMModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CheckListSMEnPoint.getData
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func confirm(id: Int, success: @escaping SuccessHandler<ComfimSMModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CheckListSMEnPoint.confirm(id: id)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
}
