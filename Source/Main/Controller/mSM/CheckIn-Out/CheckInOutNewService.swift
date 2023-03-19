//
//  CheckInOutNewService.swift
//  fptshop
//
//  Created by Sang Trương on 09/06/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON

protocol CheckInOutProtocol {
    func getUserKiemTraInOut(p_UserCode:String, success: @escaping SuccessHandler<CheckInOutResultModel>.object, failure: @escaping RequestFailure)
    func getUserCheckInOut(p_UserCode:String,p_CheckType:Int, success: @escaping SuccessHandler<UserCheckInOutResult>.object, failure: @escaping RequestFailure)
}

class CheckInOutAPIService: CheckInOutProtocol {
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getUserKiemTraInOut(p_UserCode: String, success: @escaping SuccessHandler<CheckInOutResultModel>.object, failure: @escaping RequestFailure) {
        let endPoint = CheckInOutEndPoint.getUserKiemTraInOut(p_UserCode: p_UserCode)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getUserCheckInOut(p_UserCode: String, p_CheckType: Int, success: @escaping SuccessHandler<UserCheckInOutResult>.object, failure: @escaping RequestFailure) {
        let endPoint = CheckInOutEndPoint.getUserCheckInOut(p_UserCode: p_UserCode,p_CheckType:p_CheckType)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

}

