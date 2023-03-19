//
//  ApiRequestMirae.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 25/04/2022.
//

import UIKit
import Alamofire

class ApiRequestMirae {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Decodable>(_ apiRouter: ApiRouterMirae,_ returnType: T.Type, completion: @escaping (Result<T,APIErrorType>) -> Void) {
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
                print(String(data: data, encoding: .utf8))
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
                completion(.failure(APIErrorType.defaultError(code: statusCode, message: "")))
            }
        }
    }
    
    
}
