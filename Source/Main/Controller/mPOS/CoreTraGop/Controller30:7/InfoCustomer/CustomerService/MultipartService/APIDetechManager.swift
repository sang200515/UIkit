//
//  APIDetechManager.swift
//  QuickCode
//
//  Created by Sang Trương on 19/07/2022.
//

import Moya

import Foundation
enum MPOSAPIDetechService {
    case detech_CMND(params: [String: Any])


}

extension MPOSAPIDetechService: TargetType {
    var sampleData: Data {
        return Data()
    }
    var baseURL: URL {
        return URL(string: "\(Config.manager.URL_GATEWAY!)")!
    }

    var path: String {
        switch self {
            case .detech_CMND(_):
                return "/dev-installment-service/api/customer/detach-idcard"

        }
    }

    var method: Moya.Method {
        switch self {
            case .detech_CMND:
                return .post
        }
    }

    var task: Task {
        switch self {
            case let .detech_CMND(params):
                return .requestParameters(parameters: params, encoding:  RequestMultipartFormData.encodingMemoryThreshold as! ParameterEncoding)

        }

    }

    var headers: [String : String]? {
        switch self {
            case .detech_CMND:
                return  ["Content-type": "application/json","Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token")!)"]
        }

    }


}
