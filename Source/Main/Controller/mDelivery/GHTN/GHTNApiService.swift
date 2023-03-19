//
//  GHTNApiService.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver
import ObjectMapper


class GrabBookingApiManager {
    static let shared = GrabBookingApiManager()
    private var provider: MoyaProvider<GHTNApiService> = MoyaProvider<GHTNApiService>(plugins: [VerbosePlugin(verbose: true)])
    
     func getPlainningGrab(docEntry: String,id:String,completion: @escaping ((GrabPlainingItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["DocEntry"] = docEntry
        params["Id"] = id
        params["Partner_Code"] = "GRAB"
        params["Partner_Name"] = "GRAB"
        params["UserId"] = Cache.user?.UserName
        
        provider.request(.planingGrab(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = GrabPlainingItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func bookingGrab(item: GetSOByUserResult,planning: GrabPlainingItem,partnerName:String,completion: @escaping ((BookingItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["PlanningId"] = planning.planningId
        params["PartnerName"]  = partnerName
        params["Service_Code"] = planning.services_Code
        params["UserId"] = Cache.user?.UserName
        params["Id"] = item.ID
        params["DocEntry"] = item.DocEntry
        provider.request(.bookingGrab(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = BookingItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func bookingFRT(item: GetSOByUserResult,completion: @escaping ((BookingItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["UserId"] = Cache.user?.UserName
        params["Id"] = item.ID
        params["DocEntry"] = item.DocEntry
        provider.request(.frtDelivery(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = BookingItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func cancelGrab(item: GetSOByUserResult,completion: @escaping ((BookingItem?, String) ->Void)) {
        var params: [String: Any] = [:]
        params["TransactionCode"] = item.p_ThongTinNCC_TransactionCode
        params["PartnerName"] = "GRAB"
        params["UserId"] = Cache.user?.UserName
        params["Id"] = item.ID
        params["DocEntry"] = item.DocEntry
        provider.request(.cancelGrab(params: params)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let json = try JSON(data: data)
                    let rs = BookingItem.getObjFromDictionary(data: json)
                    completion(rs,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }

}

enum GHTNApiService {
    case planingGrab(params: [String: Any])
    case bookingGrab(params: [String: Any])
    case frtDelivery(params: [String: Any])
    case cancelGrab(params: [String: Any])
}

extension GHTNApiService: TargetType {
    var path: String {
        switch self {
        case .planingGrab:
            return "/api/Delivery/FRT_SP_ADS_Planning_Order"
        case .bookingGrab:
            return "/api/Delivery/FRT_SP_ADS_Booking_Create_For_ICT"
        case .frtDelivery:
            return "/api/Delivery/sp_mDelAPI_SetFRTDelivery"
        case .cancelGrab:
            return "/api/Delivery/FRT_SP_ADS_Booking_Cancel_For_ICT"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .planingGrab, .bookingGrab, .cancelGrab, .frtDelivery:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .planingGrab(let params),.bookingGrab(let params),.cancelGrab(let params), .frtDelivery(let params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .planingGrab,.bookingGrab,.cancelGrab, .frtDelivery:
            return ["Content-Type":"application/json",
                    "Authorization" : "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"
            ]
        }
    }
    
    
    var baseURL: URL {
        switch self {
        case .planingGrab,.bookingGrab,.cancelGrab, .frtDelivery:
            return URL(string: "\(URLs.MDELIVERY_SERVICE_ADDRESS_GATEWAY)")!
        }
    }
}




enum GHTNRouter: URLRequestConvertible {
    case getListDonHang(
        userID:String,
        token:String,
        sysType:String,
        typeAPP:String
    )
    case khachTraHang(
        docNum:String,
        userCode:String,
        reason:String
    )
    case khachNhanHang(
        docNum:String,
        userCode:String,
        finishLatitude:String,
        finishLongitude:String
    )
    case getListChiTietDonHang(docNum:String)
    case upLoadImageGHTN(soSO:String,
                         fileName:String,
                         base64String:String,
                         userID:String,
                         kH_Latitude:String,
                         kH_Longitude:String,
                         type:String)
    case datGrabGiaoHang(
        docEntry: String,
        id:String,
        partnerCode:String,
        partnerName:String,
        userID:String
    )
    
    private var url:String {
        switch self {
        case    .khachTraHang,
                .khachNhanHang,
                .getListDonHang,
                .getListChiTietDonHang,
                .upLoadImageGHTN,
                .datGrabGiaoHang:
            return URLs.MDELIVERY_SERVICE_ADDRESS_GATEWAY
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case    .khachTraHang,
                .khachNhanHang,
                .getListDonHang,
                .upLoadImageGHTN,
                .datGrabGiaoHang:
            return .post
        case .getListChiTietDonHang:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .khachTraHang(docNum: let docNum,
                           userCode: let userCode,
                           reason: let reason):
            return "/api/Delivery/XacNhanKhachTraHang?docNum=\(docNum)&userCode=\(userCode)&reason=\(reason)"
        case .khachNhanHang(docNum: let docNum,
                            userCode: let userCode,
                            finishLatitude: let finishLatitude,
                            finishLongitude: let finishLongitude) :
            return "/api/Delivery/XacNhanHoanTatGiaoHang?docNum=\(docNum)&userCode=\(userCode)&finishLatitude=\(finishLatitude)&finishLongitude=\(finishLongitude)"
        case .getListDonHang:
            return "/api/Delivery/getSOByUserOneApp"
        case .getListChiTietDonHang:
            return "api/delivery/getSODetails"
        case .upLoadImageGHTN:
            return "api/delivery/mDel_UpAnh_GHTN"
        case .datGrabGiaoHang:
            return "/api/Delivery/FRT_SP_ADS_Planning_Order"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "access_token") ?? "")"]
        switch self {
        case    .khachTraHang,
                .khachNhanHang,
                .getListDonHang,
                .getListChiTietDonHang,
                .upLoadImageGHTN,
                .datGrabGiaoHang:
            break
        }
        return headers
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getListDonHang(userID: let userID,
                             token: let token,
                             sysType: let sysType,
                             typeAPP: let typeAPP):
            return [
                "UserID":userID,
                "ToKen":token,
                "SysType":sysType,
                "TypeAPP":typeAPP
            ]
        case .khachTraHang:
            return [:]
        case .khachNhanHang:
            return [:]
        case .getListChiTietDonHang(docNum: let docNumber):
            return ["docNum":docNumber]
        case .upLoadImageGHTN(soSO: let soSO,
                              fileName: let fileName,
                              base64String: let base64String,
                              userID: let userID,
                              kH_Latitude: let kH_Latitude,
                              kH_Longitude: let kH_Longitude,
                              type: let type):
            return [
                "SoSO":soSO,
                "FileName":fileName,
                "Base64String":base64String,
                "UserID":userID,
                "KH_Latitude":kH_Latitude,
                "KH_Longitude":kH_Longitude,
                "Type":type
            ]
        
        case .datGrabGiaoHang(docEntry: let docEntry,
                              id: let id,
                              partnerCode: let partnerCode,
                              partnerName: let partnerName,
                              userID: let userID):
            return [
                "DocEntry" : docEntry,
                "Id" : id,
                "Partner_Code" : partnerCode,
                "Partner_Name" : partnerName,
                "UserId" : userID
            ]
        }
    }

    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.url.asURL()
        
        let urlWithPath = url.appendingPathComponent(path).absoluteString.removingPercentEncoding
       
        var urlRequest: URLRequest = URLRequest(url: URL(string: (urlWithPath ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)

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

class GHTNApiRequest {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func request<T: Decodable>(_ apiRouter: GHTNRouter,_ returnType: T.Type, completion: @escaping (Result<T,APIErrorType>) -> Void) {
        
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

