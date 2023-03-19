//
//  MyInfoAPIServices.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya

enum MyInfoAPIServices {
    case login_beta(_ inside: String, _ password: String, _ crm_code: String)
    case getEmployeeinfo(_ inside: String)
    case getSellToday(_ inside: String)
    case getTotalTimeTwoMonths(_ inside: String)
    case getTotalINC(_ inside: String)
    case getDetailTotalTimeWorkInMonth(_ inside: String, _ month: String, _ year: String)
    case getViolationItem(_ inside: String)
    case getDetailViolationItem(_ inside: String, _ numberViolation: Int)
    case postResponseViolation(_ inside: String, _ params: [String:Any])
}

extension MyInfoAPIServices: TargetType {
    private static var _defaults = UserDefaults.standard
    var baseURL: URL {
        switch self {
        case .login_beta:
            let urlString = Config.manager.URL_GATEWAY!
            guard let url = URL(string: urlString) else {
                fatalError("Could not get url")
            }
            return url
        case .getEmployeeinfo, .getSellToday, .getTotalTimeTwoMonths, .getTotalINC, .getDetailTotalTimeWorkInMonth, .getViolationItem, .getDetailViolationItem, .postResponseViolation:
            let urlString = Config.manager.URL_GATEWAY!
            guard let url = URL(string: urlString) else {
                fatalError("Could not get Myinfo base URL")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .login_beta:
            return "/api/v1/login"
        case .getEmployeeinfo:
            return "/internal-api-service/api/inside/GetEmployeeInfo"
        case .getSellToday:
            return "/internal-api-service/api/inside/GetAlertContent_SellToday"
        case .getTotalTimeTwoMonths:
            return "/internal-api-service/api/inside/GetTotalTimeAttendanceTwoMonth"
        case .getTotalINC:
            return "/internal-api-service/api/inside/GetEmployeeIncentiveDetail"
        case .getDetailTotalTimeWorkInMonth:
            return "/internal-api-service/api/inside/GetLGC_Detail"
        case .getViolationItem:
            return "/internal-api-service/api/calllog/Get_Violation"
        case .getDetailViolationItem:
            return "/internal-api-service/api/calllog/Get_Details_Violation"
        case .postResponseViolation(_, _):
            return "/internal-api-service/api/calllog/Submit_Conversation_Violation"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login_beta, .postResponseViolation(_, _):
            return .post
        case .getEmployeeinfo, .getSellToday(_), .getTotalTimeTwoMonths, .getTotalINC(_), .getDetailTotalTimeWorkInMonth, .getViolationItem, .getDetailViolationItem:
            return .get
        }
    }
    
    var parameters: [String: String] {
        var params: [String:String] = [:]
        switch self {
        case .login_beta(let inside, let password, let crm_code):
//            params["client_id"] = "crm_web"
//            params["client_secret"] = "123456"
//            params["scope"] = "openid profile som order-api"
//            params["username"] = inside
//            params["password"] = password
//            params["grant_type"] = "password_otp"
//            params["otp"] = crm_code
            params["username"] = inside
            params["password"] = password
            params["otpCode"] = crm_code
        case .getEmployeeinfo(let inside), .getSellToday(let inside), .getTotalTimeTwoMonths(let inside), .getTotalINC(let inside), .getViolationItem(let inside):
            params["Employcode"] = inside
        case .getDetailTotalTimeWorkInMonth(let inside, let month, let year):
            params["Employcode"] = inside
            params["Month"] = month
            params["Year"] = year
        case .getDetailViolationItem (_, _):
            break
        case .postResponseViolation(_, _):
            break
        }
        return params
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        let params: [String: String] = parameters
        switch self {
        case .login_beta(_,_,_):
//            var multipartData = [MultipartFormData]()
//            for (key, value) in params {
//                let formData = MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
//                multipartData.append(formData)
//            }
//            return .uploadMultipart(multipartData)
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .getEmployeeinfo(_), .getSellToday(_), .getTotalTimeTwoMonths(_), .getTotalINC(_), .getDetailTotalTimeWorkInMonth, .getViolationItem:
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getDetailViolationItem(let inside, let numberViolation):
            var params: [String:Any] = [:]
            params["RequestID"] = numberViolation
            params["EmployCode"] = inside
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .postResponseViolation(let inside , let params):
            var paramsEmployCode: [String:Any] = [:]
            var paramsResponse: [String:Any] = [:]
            paramsResponse = params
            paramsEmployCode["Employcode"] = inside

            return Task.requestCompositeParameters(bodyParameters: paramsResponse, bodyEncoding: JSONEncoding.default, urlParameters: paramsEmployCode)
        }
    }
    
    var headers: [String : String]? {
        var access_token = MyInfoAPIServices._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        switch self {
        case .login_beta(_, _, _):
            return ["Content-Type":"application/json"]
        case .getEmployeeinfo(_), .getSellToday(_), .getTotalTimeTwoMonths(_), .getTotalINC(_), .getDetailTotalTimeWorkInMonth, .getViolationItem, .getDetailViolationItem, .postResponseViolation(_, _):
            if Config.manager.version != "Production" {
                return ["Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"]
            } else {
                return ["Authorization" : "Bearer \(access_token ?? "")"]

            }
        }
    }
    
    
}
