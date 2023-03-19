//
//  MutipleChoiceApiManager.swift
//  fptshop
//
//  Created by Ngoc Bao on 12/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

class MultipleChoiceApiManager {
    static let shared = MultipleChoiceApiManager()
    var provider: MoyaProvider<MutipleChoiceApiService> = MoyaProvider<MutipleChoiceApiService>(plugins: [VerbosePlugin(verbose: true)])

    func getUserInfoExam(completion: @escaping ((InfoExamItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["Employcode"] = Cache.user?.UserName
        provider.request(.getInfoUserExam(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = InfoExamItem.parseObjfromArray(array: json.arrayValue).first
                    if let value = rs {
                        completion(value,"")
                    } else {
                        let errData = BaseErrorExam.getObjFromDictionary(data: json)
                        let str = errData.error.message + ", " + errData.error.details
                        completion(nil,str)
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getDetailExam(ExamCode: Int,completion: @escaping ((EmployInfoExam?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["Employcode"] = Cache.user?.UserName
        params["ExamCode"] = ExamCode
        provider.request(.getDetailExam(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = EmployInfoExam.parseObjfromArray(array: json.arrayValue).first
                    if let value = rs {
                        completion(value,"")
                    } else {
                        if json == [] {
                            completion(nil,"Không có bài thi")
                        } else {
                            let errData = BaseErrorExam.getObjFromDictionary(data: json)
                            let str = errData.error.message + ", " + errData.error.details
                            completion(nil,str)
                        }
                    }
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func postResultExam(params: [String: Any],completion: @escaping ((ResultExamItem?, String) ->Void)) {
        let code = params["ExamCode"] as! Int
        let employCode = params["Employcode"] as! String
        let start = params["BeginDatetime"] as! String
        let end = params["EndDatetime"] as! String
        let baseUrl = "\(Config.manager.URL_GATEWAY ?? "")/internal-api-service"

        var newData:[bodyItem] = []
        for item in params["ExamOfUser"] as! [[String: Any]] {
            let quesCode = item["QuestionCode"] as? Int
            let ansCode = item["QuestionAnswerCode"] as? Int
            let newitem = bodyItem(QuestionCode: quesCode ?? 0, QuestionAnswerCode: ansCode ?? 0)
            newData.append(newitem)
        }

        let headers:HTTPHeaders = [
                "Authorization": "Bearer \(UserDefaults.standard.getMyInfoToken()!)",
                "Content-Type": "application/json-patch+json",
                "accept": "text/plain"
            ]
        AF.request("\(baseUrl)/api/inside/PostResultExam?ExamCode=\(code)&Employcode=\(employCode)&BeginDatetime=\(start.encoded ?? "")&EndDatetime=\(end.encoded ?? "")",
                   method: .post,
                   parameters: newData,encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: 200..<299).responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .failure(let error):
                        var errStr = ""
                        if let data = response.data {
                            let json = JSON(data)
                            let errData = BaseErrorExam.getObjFromDictionary(data: json)
                            errStr = errData.error.message + ", " + errData.error.details
                        } else {
                            errStr = error.localizedDescription
                        }
                        completion(nil,errStr)
                    case .success(let value):
                        let json = JSON(value)
                        let rs = ResultExamItem.parseObjfromArray(array: json.arrayValue).first
                        if let value = rs {
                            completion(value,"")
                        } else {
                            let errData = BaseErrorExam.getObjFromDictionary(data: json)
                            let str = errData.error.message + ", " + errData.error.details
                            completion(nil,str)
                        }
                    }
                }
    }

}

enum MutipleChoiceApiService {
    case getInfoUserExam(params: [String: Any])
    case getDetailExam(params: [String: Any])
}

extension MutipleChoiceApiService: TargetType {
    var path: String {
        switch self {
        case .getInfoUserExam:
            return "/internal-api-service/api/inside/GetInformationExam"
        case .getDetailExam:
            return "/internal-api-service/api/inside/GetDetailContentExam"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInfoUserExam, .getDetailExam:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getInfoUserExam(let params),.getDetailExam(let params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getDetailExam, .getInfoUserExam:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
    var baseURL: URL {
        switch self {
        case .getDetailExam, .getInfoUserExam:
            let urlStr = Config.manager.URL_GATEWAY ?? ""
            guard let url = URL(string: urlStr) else {
                fatalError("Could not get url")
            }
            return url
        }
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

struct bodyItem: Encodable {
    var QuestionCode: Int
    var QuestionAnswerCode: Int
}
extension String {
    var encoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
