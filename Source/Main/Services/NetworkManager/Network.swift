    //
    //  Network.swift
    //  fptshop
    //
    //  Created by Doan Minh Hoang on 09/04/2021.
    //  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
    //

import Foundation
import Alamofire
import SwiftyJSON

typealias RequestSuccess = (_ data: Data) -> Void
typealias RequestFailure = (_ error: NetworkError) -> Void
typealias NetworkSuccess = (_ data: Any) -> Void

struct SuccessHandler<T> {
    typealias object = (_ object: T?) -> Void
    typealias array = (_ array: [T]) -> Void
    typealias anyObject = (_ object: Any?) -> Void
}

protocol APINetworkProtocol {
    func cancelAllRequest()
    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func requestDataNoLoading(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func requestData(withTimeInterval interval: Double, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func requestDataBool(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
}

struct APINetwork: APINetworkProtocol {
    let request: NetworkRequestProtocol

    init(request: NetworkRequestProtocol) {
        self.request = request
    }

    func cancelAllRequest() {
        AF.session.getTasksWithCompletionHandler { session, upload, download in
            session.forEach { $0.cancel() }
            upload.forEach { $0.cancel() }
            download.forEach { $0.cancel() }
        }
    }

    func requestDataNoLoading(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("\n**************_____URL_____**************\n")
        print(endPoint.path)
        print("\n**************_____PARAMETER_____**************\n")
        print(JSON(endPoint.parameters))

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        request.requestData(endPoint: endPoint, success: { data in
            let jsonObject = JSON(data).object
            let json = JSON(data)

            let errorResponse = json["error"]
            if var message = errorResponse["message"].string {
                if let detail = errorResponse["details"].string, !detail.isEmpty {
                    message += " - " + detail
                }
                print("\n**************_____ERROR_____**************\n")
                print(json)
                failure(.unexpectedError(message: message))
            } else {
                print("\n**************_____SUCCESS_____**************\n")
                print(json)

                success(jsonObject)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }, failure: { error in
            print("\n**************_____ERROR_____**************\n")
            print(error.localizedDescription)

            failure(.networkError(error: error))
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }

    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("\n**************_____URL_____**************\n")
        print(endPoint.path)
        print("\n**************_____PARAMETER_____**************\n")
        print(JSON(endPoint.parameters))

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ProgressView.shared.show()
        request.requestData(endPoint: endPoint, success: { data in
            ProgressView.shared.hide()
            let jsonObject = JSON(data).object
            let json = JSON(data)

            let errorResponse = json["error"]
            if var message = errorResponse["message"].string {
                if let detail = errorResponse["details"].string, !detail.isEmpty {
                    message += " - " + detail
                }
                print("\n**************_____ERROR_____**************\n")
                print(json)
                failure(.unexpectedError(message: message))
            } else {
                print("\n**************_____SUCCESS_____**************\n")
                print(json)

                success(jsonObject)
            }

            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }, failure: { error in
            ProgressView.shared.hide()
            print("\n**************_____ERROR_____**************\n")
            print(error.localizedDescription)

            failure(.networkError(error: error))
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })

    }

    func requestDataBool(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("\n**************_____URL_____**************\n")
        print(endPoint.path)
        print("\n**************_____PARAMETER_____**************\n")
        print(JSON(endPoint.parameters))

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ProgressView.shared.show()
        request.requestDataBool(endPoint: endPoint, success: { data in
            ProgressView.shared.hide()
            success(data)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }, failure: { error in
            ProgressView.shared.hide()
            print("\n**************_____ERROR_____**************\n")
            print(error.localizedDescription)

            failure(.networkError(error: error))
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }

    func requestData(withTimeInterval interval: Double, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("\n**************_____URL_____**************\n")
        print(endPoint.path)
        print("\n**************_____PARAMETER_____**************\n")
        print(JSON(endPoint.parameters))

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ProgressView.shared.show()
        request.requestData(withTimeInterval: interval, endPoint: endPoint, success: { data in
            ProgressView.shared.hide()
            let jsonObject = JSON(data).object
            let json = JSON(data)

            let errorResponse = json["error"]
            if var message = errorResponse["message"].string {
                if let detail = errorResponse["details"].string, !detail.isEmpty {
                    message += " - " + detail
                }
                print("\n**************_____ERROR_____**************\n")
                print(json)
                failure(.unexpectedError(message: message))
            } else {
                print("\n**************_____SUCCESS_____**************\n")
                print(json)

                success(jsonObject)
            }

            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }, failure: { error in
            ProgressView.shared.hide()
            print("\n**************_____ERROR_____**************\n")
            print(error.localizedDescription)

            failure(.networkError(error: error))
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
}

