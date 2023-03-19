//
//  NetworkRequest.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequestProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func requestDataBool(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func requestData(withTimeInterval interval: Double, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
}

class NetworkRequest: NetworkRequestProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {

        let url = endPoint.path
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        let request = AF.request(url,
                                        method    : endPoint.httpMethod,
                                        parameters: endPoint.parameters,
                                        encoding  : encoding,
                                        headers   : endPoint.headers)
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success(let data):
                if let response = dataResponse.response {
                    let statusCode = response.statusCode
                    DetailThuHoEbayVC.statusCode = statusCode
                    self.handleNetworkResponse(data: data, status: statusCode, success: success, failure: failure)
                } else {
                    failure(.unexpectedError(message: "Không có data trả về"))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    failure(.unexpectedError(message: "Request timeout!"))
                default:
                    failure(.networkError(error: error))
                }
            }
        }
    }
    
    func requestDataBool(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {

        let url = endPoint.path
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        let request = AF.request(url,
                                        method    : endPoint.httpMethod,
                                        parameters: endPoint.parameters,
                                        encoding  : encoding,
                                        headers   : endPoint.headers)
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success(_):
                if let response = dataResponse.response {
                    let statusCode = response.statusCode
                    self.handleNetworkResponseBool(status: statusCode, success: success, failure: failure)
                } else {
                    failure(.unexpectedError(message: "Không có data trả về"))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    failure(.unexpectedError(message: "Request timeout!"))
                default:
                    failure(.networkError(error: error))
                }
            }
        }
    }
    
    func requestData(withTimeInterval interval: Double, endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {

        let url = endPoint.path
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        let request = AF.request(url,
                                        method    : endPoint.httpMethod,
                                        parameters: endPoint.parameters,
                                        encoding  : encoding,
                                        headers   : endPoint.headers) { $0.timeoutInterval = interval }
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success(let data):
                if let response = dataResponse.response {
                    let statusCode = response.statusCode
                    self.handleNetworkResponse(data: data, status: statusCode, success: success, failure: failure)
                } else {
                    failure(.unexpectedError(message: "Không có data trả về"))
                }
            case .failure(let error):
                switch error {
                case .sessionTaskFailed(let urlError as URLError) where urlError.code == .timedOut:
                    failure(.unexpectedError(message: "Request timeout!"))
                default:
                    failure(.networkError(error: error))
                }
            }
        }
    }
    
    private func handleNetworkResponse(data: Data, status: Int, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
//        switch status {
//        case 200...299:
//            success(data)
//        case 401:
//            UIApplication.shared.topMostViewController().showAlertOneButton(title: "Thông báo", with: NetworkResponse.authenticationError.rawValue, titleButton: "OK", handleOk: {
//                LoginViewModel().handleLogout()
//            })
//        case 402:
//            failure(.unexpectedError(message: "Cần hoàn thành thanh toán"))
//        case 403:
//            failure(.unexpectedError(message: "Bạn không có quyền truy cập vào mục này"))
//        case 404:
//            failure(.unexpectedError(message: "Không tìm thấy file"))
//        case 500:
//            failure(.unexpectedError(message: "Lỗi server"))
//        case 501...599:
//            failure(.unexpectedError(message: NetworkResponse.badRequest.rawValue))
//        case 600:
//            failure(.unexpectedError(message: NetworkResponse.outdated.rawValue))
//        default:
//            failure(.unexpectedError(message: NetworkResponse.failed.rawValue))
//        }
        switch status {
        case 401:
            UIApplication.shared.topMostViewController().showAlertOneButton(title: "Thông báo", with: NetworkResponse.authenticationError.rawValue, titleButton: "OK", handleOk: {
                LoginViewModel().handleLogout()
            })
        default:
            success(data)
        }
    }
    
    private func handleNetworkResponseBool(status: Int, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        switch status {
        case 200:
            success(true)
        case 401:
            UIApplication.shared.topMostViewController().showAlertOneButton(title: "Thông báo", with: NetworkResponse.authenticationError.rawValue, titleButton: "OK", handleOk: {
                LoginViewModel().handleLogout()
            })
        default:
            success(false)
        }
    }
}

extension NetworkRequest {
    private func getAlamofireEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }

}

extension UIApplication {
    func topMostViewController() -> UIViewController {
        return self.keyWindow?.rootViewController?.topMostViewController() ?? UIViewController()
    }


}
