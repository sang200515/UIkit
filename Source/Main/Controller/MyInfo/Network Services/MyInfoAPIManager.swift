//
//  MyInfoAPIManager.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

fileprivate protocol MyInfoAPIManagerProtocol {
    var provider: MoyaProvider<MyInfoAPIServices> { get }
    func getTokenMyInfo(_ userInside: String, _ password: String, _ crm_code: String, completion: @escaping(String?, String?) -> Void)
    func getEmployeeInfo(_ inside: String, completion: @escaping(EmployeeInfoElement?) -> Void, failure: @escaping(String?) -> Void)
    func getSellToday(_ inside: String, completion: @escaping(SellTodayItem?, String?) -> Void)
    func getTotalTimeTwoMonths(_ inside: String, completion: @escaping([TotalTimeTwoMonthsItem]?, String?) -> Void)
    func getTotalINC(_ inside: String, completion: @escaping(TotalINCItem?, String?) -> Void)
    func getTotalTimeWorkInMont(_ inside: String, _ month: String, _ year: String, completion: @escaping(DetailTotalTimeWorkInMontItem?, String?) -> Void)
    func getViolationItem(_ inside: String, completion: @escaping([ViolationItem]?, String?) -> Void)
    func getDetailViolationItem(_ inside: String, requestId: Int, completeion: @escaping(ViolationInfoDetailItem?, String?) -> Void)
    func postResponseViolationSubmit(_ inside: String, _ params: [String:Any], completion: @escaping(ResponseSubmitViolationItem?, String?) -> Void)
}

class MyInfoAPIManager: MyInfoAPIManagerProtocol {
    
    static let shared = MyInfoAPIManager()
    var provider: MoyaProvider<MyInfoAPIServices> = MoyaProvider<MyInfoAPIServices>( plugins: [VerbosePlugin(verbose: true)])
    let decoder = JSONDecoder()
    
    func getTokenMyInfo(_ userInside: String, _ password: String, _ crm_code: String, completion: @escaping (String?, String?) -> Void) {
        provider.request(.login_beta(userInside, password, crm_code)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myInfoItem = try strongSelf.decoder.decode(MyInfoLoginItem.self, from: response.data)
                    printLog(function: #function, json: myInfoItem)
                    if let token = myInfoItem.accessToken {
                        completion(token,nil)
                    } else {
                        completion(nil, "Không đúng thông tin đăng nhập")
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getEmployeeInfo(_ inside: String, completion: @escaping (EmployeeInfoElement?) -> Void, failure: @escaping (String?) -> Void) {
        provider.request(.getEmployeeinfo(inside)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let employeeInfoItems = try strongSelf.decoder.decode([EmployeeInfoElement].self, from: jsonData)
                        printLog(function: #function, json: employeeInfoItems)
                        if !employeeInfoItems.isEmpty {
                            employeeInfoItems.forEach{completion($0)}
                        } else {
                            failure("Không có dữ liệu")
                        }
                    case .failure(let error):
                        failure(error)
                    }
                    
                } catch let err {
                    failure(err.localizedDescription)
                }
            case let .failure(err):
                failure(err.localizedDescription)
            }
        }
    }
    
    func getSellToday(_ inside: String, completion: @escaping (SellTodayItem?, String?) -> Void) {
        provider.request(.getSellToday(inside)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let sellTodayItems = try strongSelf.decoder.decode([SellTodayItem].self, from: jsonData)
                        printLog(function: #function, json: sellTodayItems)
                        sellTodayItems.forEach{completion($0, nil)}
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
            
        }
    }
    
    func getTotalTimeTwoMonths(_ inside: String, completion: @escaping ([TotalTimeTwoMonthsItem]?, String?) -> Void) {
        provider.request(.getTotalTimeTwoMonths(inside)) {[weak self] (result) in
            guard let strongSelf = self else {return}
            
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let totalTimeItem = try strongSelf.decoder.decode([TotalTimeTwoMonthsItem].self, from: jsonData)
                        printLog(function: #function, json: totalTimeItem)
                        completion(totalTimeItem, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getTotalINC(_ inside: String, completion: @escaping(TotalINCItem?, String?) -> Void) {
        provider.request(.getTotalINC(inside)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let totalINCItem = try strongSelf.decoder.decode([TotalINCItem].self, from: jsonData)
                        printLog(function: #function, json: totalINCItem)
                        totalINCItem.forEach{completion($0, nil)}
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getTotalTimeWorkInMont(_ inside: String, _ month: String, _ year: String, completion: @escaping (DetailTotalTimeWorkInMontItem?, String?) -> Void) {
        provider.request(.getDetailTotalTimeWorkInMonth(inside, month, year)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let totalTimeWorkItems = try strongSelf.decoder.decode([DetailTotalTimeWorkInMontItem].self, from: jsonData)
                        printLog(function: #function, json: jsonData)
                        totalTimeWorkItems.forEach{completion($0, nil)}
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getViolationItem(_ inside: String, completion: @escaping ([ViolationItem]?, String?) -> Void) {
        provider.request(.getViolationItem(inside)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let violationItems = try strongSelf.decoder.decode([ViolationItem].self, from: jsonData)
                        printLog(function: #function, json: response)
                        completion(violationItems, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getDetailViolationItem(_ inside: String, requestId: Int, completeion: @escaping(ViolationInfoDetailItem?, String?) -> Void) {
        provider.request(.getDetailViolationItem(inside, requestId)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let violationDetailInfoItem = try strongSelf.decoder.decode(ViolationInfoDetailItem.self, from: jsonData)
                        printLog(function: #function, json: violationDetailInfoItem)
                        completeion(violationDetailInfoItem, nil)
                    case.failure(let error):
                        completeion(nil, error)
                    }
                } catch let err {
                    completeion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completeion(nil, err.localizedDescription)
            }
        }
    }
    
    func postResponseViolationSubmit(_ inside: String, _ params: [String:Any], completion: @escaping(ResponseSubmitViolationItem?, String?) -> Void) {
        provider.request(.postResponseViolation(inside, params)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let myResponse = Common.handleNetworkResponse(response)
                    switch myResponse {
                    case .success:
                        let jsonData = response.data
                        let responseItemSubmit = try strongSelf.decoder.decode(ResponseSubmitViolationItem.self, from: jsonData)
                        printLog(function: #function, json: responseItemSubmit)
                        completion(responseItemSubmit, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
}

