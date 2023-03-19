//
//  VASViettelService.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//



import Foundation
import UIKit
import Moya


enum VASViettelService {
    case getPaymentType
    case getCards
    case addCard(params: [String: Any])
}

extension VASViettelService: TargetType {
    var path: String {
        switch self {
        case .getPaymentType:
            return "/som-product-service/api/Product/v1/PaymentTypes"
        case .getCards:
            return "/som-product-service/api/Product/v1/Cards"
        case .addCard:
            return "/som-order-service/api/Order/v1/order/calculate?action=1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPaymentType, .getCards:
            return .get
        case .addCard:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPaymentType, .getCards:
            return .requestPlain
        case .addCard(let params):            
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPaymentType, .getCards, .addCard:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
    var baseURL: URL {
        switch self {
        case .getPaymentType, .getCards, .addCard:
            let urlString = Config.manager.URL_GATEWAY!
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
}
