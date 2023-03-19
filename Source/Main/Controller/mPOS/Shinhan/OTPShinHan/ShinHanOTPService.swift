//
//  ShinHanOTPService.swift
//  QuickCode
//
//  Created by Sang Trương on 15/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ShinHanOTPProtocol {
    func getOTP(mposNumber:String, success: @escaping SuccessHandler<ShinHanOTPModel>.object, failure: @escaping RequestFailure)
    func verifyOTP(mposNumber:String,OTP:String, success: @escaping SuccessHandler<ShinHanOTPModel>.object, failure: @escaping RequestFailure)

}

class ShinHanOTPService: ShinHanOTPProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getOTP(mposNumber:String, success: @escaping SuccessHandler<ShinHanOTPModel>.object, failure: @escaping RequestFailure) {
        let endPoint = ShinHanOTPEndpoint.getOTP(mposNumber: mposNumber)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
 func verifyOTP(mposNumber:String,OTP:String, success: @escaping SuccessHandler<ShinHanOTPModel>.object, failure: @escaping RequestFailure){
        let endPoint = ShinHanOTPEndpoint.verifyOTP(mposNumber: mposNumber, OTP: OTP)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }



}

