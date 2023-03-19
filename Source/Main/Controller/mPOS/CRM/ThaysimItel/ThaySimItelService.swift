//
//  ThaySimItelService.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol ThaySimItelApiServiceProtocol {
    func getOtp(phone: String,fullName: String,birthDay: String,cmnd:String,dateCmnd:String, success: @escaping SuccessHandler<OtpItelItem>.object, failure: @escaping RequestFailure)
    func chnageSimhong(Msisdn: String,Seri: String,Esim: String,Doctal: String,FullName: String,Otp:String, success: @escaping SuccessHandler<OtpItelItem>.object, failure: @escaping RequestFailure)
}
class ThaySimItelApiService: ThaySimItelApiServiceProtocol {
    

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getOtp(phone: String, fullName: String, birthDay: String, cmnd: String, dateCmnd: String, success: @escaping SuccessHandler<OtpItelItem>.object, failure: @escaping RequestFailure) {
        let endPoint = ThaySimItelEndpoint.getOtp(phone: phone, name: fullName, birthday: birthDay, cmnd: cmnd, dateCmnd: dateCmnd)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func chnageSimhong(Msisdn: String, Seri: String, Esim: String, Doctal: String, FullName: String, Otp: String, success: @escaping SuccessHandler<OtpItelItem>.object, failure: @escaping RequestFailure) {
        let endPoint = ThaySimItelEndpoint.changeSimhong(Msisdn: Msisdn, Seri: Seri, Esim: Esim, Doctal: Doctal, FullName: FullName, Otp: Otp)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
