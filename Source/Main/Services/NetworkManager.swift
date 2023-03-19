//
//  NetworkManager.swift
//  fptshop
//
//  Created by Ngo Dang tan on 18/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import SwiftyBeaver
import Alamofire

class NetworkManager {
    private lazy var loginViewModel = LoginViewModel()
    
    func request<T: Decodable, U: TargetType>(target: U, completion: @escaping (Result<T, NetworkError>) -> ()) {
        MoyaProvider<U>(plugins: [NetworkLoggerPlugin()]).request(target) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    switch response.statusCode{
                    case 401:
                        self.loginViewModel.handleLogout()
                    default:
                        let json = try? JSON(data: response.data)
                        #if PRODUCTION
                        print("DEBUG: \(json as Any)")
                        #else
                        let log = SwiftyBeaver.self
                        log.debug(json as Any)
                        #endif
                        
                        let errorResponse = json?["error"]
                        if let message = errorResponse?["message"].string {
                            completion(.failure(.unexpectedError(message: message)))
                        } else {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(.success(results))
                        }
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(.unexpectedError(message: context.debugDescription)))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print(error)
                    completion(.failure(.networkError(error: error)))
                }
            case let .failure(error):
                completion(.failure(.networkError(error: error)))
            }
        }
    }
    
    func requestWithTimeout<T: Decodable, U: TargetType>(target: U, timeout: Double, completion: @escaping (Result<T, NetworkError>) -> ()) {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let manager = Alamofire.Session(configuration: configuration)
        
        MoyaProvider<U>(session: manager, plugins: [NetworkLoggerPlugin()]).request(target) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    switch response.statusCode{
                    case 401:
                        self.loginViewModel.handleLogout()
                    default:
                        let json = try? JSON(data: response.data)
                        #if PRODUCTION
                        print("DEBUG: \(json as Any)")
                        #else
                        let log = SwiftyBeaver.self
                        log.debug(json as Any)
                        #endif
                        
                        let errorResponse = json?["error"]
                        if let message = errorResponse?["message"].string {
                            completion(.failure(.unexpectedError(message: message)))
                        } else {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(.success(results))
                        }
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(.unexpectedError(message: context.debugDescription)))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print(error)
                    completion(.failure(.networkError(error: error)))
                }
            case let .failure(error):
                completion(.failure(.networkError(error: error)))
            }
        }
    }
}

enum NetworkError: Error, CustomStringConvertible {
    case networkError(error: Error)
    case unexpectedError(message: String)
    
    public var description: String {
        switch self {
        case .networkError(let error):
            return error.localizedDescription
        case .unexpectedError(let message):
            return message
        }
    }
}
