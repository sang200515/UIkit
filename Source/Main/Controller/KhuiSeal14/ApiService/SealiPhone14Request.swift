//
//  SealiPhone14Request.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit
import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa


class SealiPhone14RequestRx {

    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Decodable>(_ apiRouter: SealiPhone14Router,_ returnType: T.Type) -> Observable<Result<T,APIErrorType>> {
        
        if !isConnectedToInternet() {
            return .just(.failure(.invalidNetWork))
        }
        
        return RxAlamofire.requestData(apiRouter)
            .debug()
            .observe(on: MainScheduler.asyncInstance)
            .map { response,data in
                let statusCode = response.statusCode
                if statusCode == 401 {
                    return .failure(.code401)
                }
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    return .success(json)
                } catch {
                    return .failure(.defaultError(code: statusCode, message: "Đã có lỗi xảy ra khi gọi tới máy chủ."))
                }
            }

    }

}



