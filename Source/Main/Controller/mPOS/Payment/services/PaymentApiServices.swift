//
//  PaymentApiServices.swift
//  fptshop
//
//  Created by Ngoc Bao on 19/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PaymentApiServicesProtocol {
    func getRulesPayment(walletCode:String,rdr1: String,promos: String, success: @escaping SuccessHandler<WalletRuleItem>.object, failure: @escaping RequestFailure)
}

class PaymentApiServices: PaymentApiServicesProtocol {
  
    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
  
    func getRulesPayment(walletCode: String, rdr1: String, promos: String, success: @escaping SuccessHandler<WalletRuleItem>.object, failure: @escaping RequestFailure) {
        let endPoint = PaymentEndPoint.getRules(WalletCode: walletCode, rdr1: rdr1, promos: promos)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
