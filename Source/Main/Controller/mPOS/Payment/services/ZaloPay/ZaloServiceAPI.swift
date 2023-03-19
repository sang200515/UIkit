//
//  ZaloServiceAPI.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 26/09/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//


import Foundation
import Alamofire

enum APIRouterZaloPay: URLRequestConvertible {
    case genQRCode(
        amount:Int,phone:String,items:String
    )
    case checkTransaction(
        paymentRequestCode:String
    )
    
    private var url:String {
        let baseUrl = Config.manager.URL_GATEWAY!
        switch self {
            case    .genQRCode,
                    .checkTransaction:
                return baseUrl + "/mpos-cloud-api/api/ZaloPay/"
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case    .genQRCode,
                .checkTransaction:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .genQRCode :
            return "genQRCode"
        case .checkTransaction :
            return "CheckTransaction"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers:HTTPHeaders = ["Content-Type": "application/json"]
        switch self {
        case    .genQRCode,
                .checkTransaction:
             headers["Authorization"] = "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
        }
        return headers
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .genQRCode(amount: let amount, phone: let phone, items: let items):
            return [
                "usercode": Cache.user!.UserName,
                "shopCode": Cache.user!.ShopCode,
                "amount": amount,
                "device": 2,
                "phone": phone,
                "items": items
            ]
        case .checkTransaction(paymentRequestCode: let paymentRequestCode):
            return [
                "Usercode" : Cache.user!.UserName,
                "ShopCode": Cache.user!.ShopCode,
                "Device": 2,
                "paymentRequestCode": paymentRequestCode
            ]
        }
        
    }

    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.url.asURL()

        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = self.method.rawValue

        self.headers.forEach { (header) in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        if let parameters = self.parameters {
            do {
                if urlRequest.httpMethod == "GET" {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }else {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                print("Encoding Parameters fail")
            }
        }
        
        return urlRequest
    }
    
}

class APIRequestZalo {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Decodable>(_ apiRouter: APIRouterZaloPay,_ returnType: T.Type, completion: @escaping (Result<T,APIErrorType>) -> Void) {
        if !isConnectedToInternet() {
            AlertManager.shared.alertWithRootViewController(title: "", message: "Không có kết nối internet", titleButton: "OK") {
                
            }
            return
        }
        
        AF.request(apiRouter).response { (response) in
        
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(APIErrorType.vpnError))
                return
            }
            switch statusCode {
            case 0: completion(.failure(APIErrorType.vpnError))
                return
            case 400: completion(.failure(APIErrorType.code400))
                return
            case 401: completion(.failure(APIErrorType.code401))
                return
            case 403: completion(.failure(APIErrorType.code403))
                return
            case 404: completion(.failure(APIErrorType.code404))
                return
            case 405: completion(.failure(APIErrorType.code405))
                return
            case 503: completion(.failure(APIErrorType.code503))
                return
            default:
                break
            }
            
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let stringJSON = json as? String {
                        print(stringJSON)
                        let dataJSON = Data(stringJSON.replacingOccurrences(of: "\\", with: "").utf8)
                        let JSON = try JSONDecoder().decode(T.self, from: dataJSON)
                        completion(.success(JSON))
                    }else {
                        let JSON = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(JSON))
                    }
                }catch {
                    completion(.failure(APIErrorType.invalidPaserData))
                }
            case .failure(let error) :
                if error._code == NSURLErrorTimedOut {
                    completion(.failure(APIErrorType.requestTimeout))
                    return
                }
                completion(.failure(APIErrorType
                                        .defaultError(
                                            code: statusCode,
                                            message: error.localizedDescription)))
            }
        }
    }
    
    
}


struct ZaloGenQRCodeModel: Codable {
    let success: Int?
    let message, paymentRequestCode, qRcode: String?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
        case paymentRequestCode = "PaymentRequestCode"
        case qRcode = "QRcode"
    }
}
