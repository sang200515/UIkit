//
//  SealiPhone14Router.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import Alamofire

enum SealiPhone14Router: URLRequestConvertible {
    case getOTP(
        userCode: String,
        shopCode: String,
        phone: String
    )
    case verifyOTP(
        userCode: String,
        shopCode: String,
        phone: String,
        OTP: String,
        ID_OTP: Int
    )
    case getContent(
        userCode: String,
        shopCode: String,
        id_OTP: Int,
        id:Int
    )
    case finishPledge(
        userCode: String,
        shopCode: String,
        nameCustomer: String,
        cmnd: String,
        ngayCap: String,
        noiCap: String,
        phone: String,
        sanPham: String,
        base64ChuKy: String,
        ID_OTP: Int
    )
    case getListHistory (
        typeFind:String,
        keySearch:String
    )
    case finishSeal(
        UserCode: String,
        ShopCode: String,
        id: Int,
        Imei: String,
        urlImageOpenSeal: String
    )
    case uploadIMGSeal(
        base64:String,
        folder: String,
        filename: String
    )
    
    private var url:String {
        switch self {
        case    .getOTP,
                .verifyOTP,
                .getContent,
                .finishPledge,
                .getListHistory,
                .finishSeal,
                .uploadIMGSeal:
            return Config.manager.URL_GATEWAY
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case    .getOTP,
                .verifyOTP,
                .finishPledge,
                .finishSeal,
                .uploadIMGSeal:
            return .post
        case .getListHistory,.getContent:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getOTP:
            return "/mpos-cloud-api/api/IphoneOpenSeal/GetOTPCustomerOpenSeal"
        case .verifyOTP:
            return "/mpos-cloud-api/api/IphoneOpenSeal/VerifyOTPCustomerOpenSeal"
        case .getContent:
            return "/mpos-cloud-api/api/IphoneOpenSeal/GetInfoCustomerOpenSealByID"
        case .finishPledge:
            return "/mpos-cloud-api/api/IphoneOpenSeal/SaveCustomerOpenSeal"
        case .getListHistory:
            return "/mpos-cloud-api/api/IphoneOpenSeal/GetListHistoryCustomerOpenSeal"
        case .finishSeal:
            return "/mpos-cloud-api/api/IphoneOpenSeal/CompleteOpenSealCustomer"
        case .uploadIMGSeal:
            return "/mpos-cloud-api/api/Upload/file"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers:HTTPHeaders = ["Content-Type": "application/json"]
        switch self {
        case    .getOTP,
                .verifyOTP,
                .getContent,
                .finishPledge,
                .getListHistory,
                .finishSeal,
                .uploadIMGSeal:
            headers["Authorization"] = UserDefaults.standard.string(forKey: "access_token")
        }
        return headers
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getOTP(userCode: let userCode, shopCode: let shopCode, phone: let phone):
            return [
                "userCode": userCode,
                "shopCode": shopCode,
                "device": 2,
                "phone": phone
            ]
        case .verifyOTP(userCode: let userCode, shopCode: let shopCode, phone: let phone, OTP: let OTP, ID_OTP: let ID_OTP):
            return [
                "userCode": userCode,
                "shopCode": shopCode,
                "device": 2,
                "phone": phone,
                "OTP": OTP,
                "ID_OTP": ID_OTP
            ]
        case .getContent(userCode: let userCode, shopCode: let shopCode, id_OTP: let id_OTP, id: let id):
            return [
                "userCode": userCode,
                "shopCode": shopCode,
                "id": id,
                "ID_OTP": id_OTP
            ]
        case .finishPledge(userCode: let userCode,
                           shopCode: let shopCode,
                           nameCustomer: let nameCustomer,
                           cmnd: let cmnd,
                           ngayCap: let ngayCap,
                           noiCap: let noiCap,
                           phone: let phone,
                           sanPham: let sanPham,
                           base64ChuKy: let base64ChuKy,
                           ID_OTP: let ID_OTP):
            return [
                "userCode": userCode,
                "shopCode": shopCode,
                "device": 2,
                "phone": phone,
                "nameCustomer": nameCustomer,
                "cmnd": cmnd,
                "ngayCap": ngayCap,
                "noiCap": noiCap,
                "sanPham": sanPham,
                "base64ChuKy":base64ChuKy,
                "ID_OTP": ID_OTP
            ]
        case .getListHistory(typeFind: let typeFind, keySearch: let keySearch):
            return [
              "typeFind" : typeFind,
              "keySearch" : keySearch
            ]
        case .finishSeal(UserCode: let UserCode, ShopCode: let ShopCode, id: let id, Imei: let Imei, urlImageOpenSeal: let urlImageOpenSeal):
            return [
                "UserCode": UserCode,
                "ShopCode": ShopCode,
                "Device": 2,
                "ID": id,
                "Imei": Imei,
                "UrlImageOpenSeal": urlImageOpenSeal
            ]
        case .uploadIMGSeal(base64: let base64, folder: let folder, filename: let filename):
            return [
                "base64":base64,
                "folder":folder,
                "filename":filename,
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
