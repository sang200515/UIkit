//
//  APIService.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire

enum APIService {
    case login(UserName:String,Password:String,CRMCode:String,SysType:String)
    case checkVersion
    case registerDeviceToken(param: [String: String])
    case removeDeviceToken(param: [String: String])
    case sp_mpos_FRT_SP_GetNotify_oneapp(param: [String: String])
    case sp_mpos_FRT_SP_delete_notify(param: [String: String])
    case sp_mpos_FRT_SP_notify_update(param: [String: String])
    case checkUserCheckInV2(param: [String: String])
    case checkUserCheckOut(param: [String: String])
    case getListShiftDate(param: [String: String])
    case insertCheckIn(param: [String: String])
    case insertCheckOut(param: [String: String])
    case sp_mpos_FRT_SP_oneapp_CheckMenu(param: [String: String])
    case searchContacts(param: [String: String])
    case checkOTP(param: [String: String])
    case getOTP(param: [String: String])
    case sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(param: [String: String])
    case mpos_sp_GateWay_GetInfoLogin(param: [String: String])
 
    case require_sso_token(param: [String: String])
    case mpos_FRT_SP_authen_get_list_shop_by_user(param: [String: String])
    
    case mpos_FRT_Call_Customer_GetData(params: [String: String])
    case mpos_FRT_Call_Customer_UpdateInfo(params: [String: String])
    case tokenAD
    case userInfoAD
    case gateway_login(param: [String: String])
    //GNNB
    case gnnbv2_GetTransport(params: [String: String])
    case gnnbv2_ScanQRCodeVerify(params: [String: Any])
    case gnnbv2_ScanQRCode(params: [String: String])
    case gnnbv2_GenQRCodeImg(params: [String: String])
    case gnnbv2_UnBookBill(params: [String: String])
    case gnnbv2_UnBookListBill(params: [String: Any])
    case checkWhs(params: [String: Any])
    case createYCDC(params: [String: Any])
    case searchYCDC(params: [String: Any])
    case cancelYCDC(params: [String: Any])
    case approledYCDC(params: [String: Any])
    case detailYCDC(params: [String: Any])
    case searchVanDon(params: [String: Any])
    case approveVanDon(params: [String: Any])
    case nhaVanChuyen
    case searchShop
    case masterdataWhs(params: [String: Any])
    case checkSOBH(params: [String: Any])
}
extension APIService: TargetType {
    private static var _defaults = UserDefaults.standard
    private static var _manager = Config.manager
    
    var baseURL: URL {
        switch self {
        case .tokenAD,.userInfoAD, .checkWhs,.createYCDC,.searchYCDC,.cancelYCDC,.approledYCDC,.detailYCDC,.searchVanDon,.approveVanDon,.nhaVanChuyen,.searchShop,.masterdataWhs,.checkSOBH:
            return URL(string: "\(Config.manager.URL_GATEWAY!)")!
        case .checkUserCheckInV2,.checkUserCheckOut,.getListShiftDate,.insertCheckIn,.insertCheckOut, .searchContacts:
            return URL(string: "\(Config.manager.URL_GATEWAY!)/mpos-cloud-callogapi")!
        case .registerDeviceToken,.removeDeviceToken,.sp_mpos_FRT_SP_GetNotify_oneapp,.sp_mpos_FRT_SP_delete_notify,.sp_mpos_FRT_SP_notify_update,.sp_mpos_FRT_SP_oneapp_CheckMenu:
            return URL(string: "\(APIService._manager.URL_GATEWAY!)")!
        case .login:
            return URL(string: "\(APIService._manager.URL_GATEWAY!)")!
        case .checkOTP,.getOTP:
            return URL(string: "\(Config.manager.URL_GATEWAY!)")!
        case .sp_mpos_FRT_SP_Check_quyen_gen_otp_getway,.mpos_FRT_SP_authen_get_list_shop_by_user, .mpos_FRT_Call_Customer_GetData, .mpos_FRT_Call_Customer_UpdateInfo:
            return URL(string: "\(APIService._manager.URL_GATEWAY!)")!
        case .mpos_sp_GateWay_GetInfoLogin,.gateway_login,.require_sso_token, .gnnbv2_GetTransport, .gnnbv2_ScanQRCodeVerify, .gnnbv2_ScanQRCode, .gnnbv2_GenQRCodeImg, .gnnbv2_UnBookBill, .gnnbv2_UnBookListBill:
            return URL(string: "\(APIService._manager.URL_GATEWAY!)")!
        case .checkVersion:
            return URL(string: "\(APIService._manager.URL_GATEWAY!)")!
        }
    }
    var path: String {
        switch self {
        case .login(_,_,_,_):
            return "/mpos-cloud-delivery/api/Notification/mpos_sp_inov_Authenticate"
        case .checkVersion:
            return "/mpos-cloud-delivery/api/Notification/sp_mpos_Get_AllVersion_MobileAll"
        case .registerDeviceToken(_):
            return "/mpos-cloud-delivery/api/Notification/registerDeviceToken"
        case .removeDeviceToken(_):
            return "/mpos-cloud-delivery/api/Notification/removeDeviceToken_V2"
        case .sp_mpos_FRT_SP_GetNotify_oneapp(_):
            return "/mpos-cloud-delivery/api/Notification/sp_mpos_FRT_SP_GetNotify_oneapp"
        case .sp_mpos_FRT_SP_delete_notify(_):
            return "/mpos-cloud-delivery/api/Notification/sp_mpos_FRT_SP_delete_notify"
        case .sp_mpos_FRT_SP_notify_update(_):
            return "/mpos-cloud-delivery/api/Notification/sp_mpos_FRT_SP_notify_update"
        case .checkUserCheckInV2(_):
            return "/MSM/Service.svc/checkUserCheckInV2"
        case .checkUserCheckOut(_):
            return "/MSM/Service.svc/checkUserCheckOut"
        case .getListShiftDate(_):
            return "/MSM/Service.svc/getListShiftDate"
        case .insertCheckIn(_):
            return "/MSM/Service.svc/insertCheckIn"
        case .insertCheckOut(_):
            return "/MSM/Service.svc/insertCheckOut"
        case .sp_mpos_FRT_SP_oneapp_CheckMenu(_):
            return "/mpos-cloud-delivery/api/Notification/sp_mpos_FRT_SP_oneapp_CheckMenu"
        case .searchContacts:
            return "/MSM/Service.svc/searchContacts";
        case .checkOTP(_):
            return "/api/v1/otp"
        case .getOTP(_):
            return "/api/v1/otp"
        case .sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(_):
            return "/mpos-cloud-api/api/Account/sp_mpos_FRT_SP_Check_quyen_gen_otp_getway"
        case .mpos_sp_GateWay_GetInfoLogin:
            return "/mpos-cloud-api/api/Notification/mpos_sp_GateWay_GetInfoLogin"
        case .require_sso_token(_):
            return "/api/v1/sso/require"
        case .mpos_FRT_SP_authen_get_list_shop_by_user(_):
            return "/mpos-cloud-api/api/notification/mpos_FRT_SP_authen_get_list_shop_by_user"
        case .mpos_FRT_Call_Customer_GetData(_):
            return "/mpos-cloud-api/api/Customer/mpos_FRT_Call_Customer_GetData"
        case .mpos_FRT_Call_Customer_UpdateInfo(_):
            return "/mpos-cloud-api/api/Customer/mpos_FRT_Call_Customer_UpdateInfo"
        case .tokenAD:
            return "/identity-api-service/connect/token"
        case .userInfoAD:
            return "/identity-api-service/connect/userinfo"
        case .gateway_login(_):
            return "/api/v1/login"
        //gnnb v2
        case .gnnbv2_GetTransport(_):
            return "/pos-transport-service/api/Tracking/GetTransport"
        case .gnnbv2_ScanQRCodeVerify(_):
            return "/pos-transport-service/api/Tracking/ScanQRCodeVerify"
        case .gnnbv2_ScanQRCode(_):
            return "/pos-transport-service/api/Tracking/ScanQRCode"
        case .gnnbv2_GenQRCodeImg(_):
            return "/pos-transport-service/api/Tracking/User"
        case .gnnbv2_UnBookBill(_):
            return "/pos-transport-service/api/Tracking/UnBook"
        case .gnnbv2_UnBookListBill(_):
            return "/pos-transport-service/api/Tracking/UnBookList"
        case .checkWhs(_):
            return "/promotion-service/api/YCDC/CheckWhs"
        case .createYCDC(_):
            return "/promotion-service/api/YCDC/Create"
        case .searchYCDC(_):
            return "/promotion-service/api/YCDC/Search"
        case .cancelYCDC(_):
            return "/promotion-service/api/YCDC/Cancel"
        case .approledYCDC(_):
            return "/promotion-service/api/YCDC/Approled"
        case .detailYCDC(_):
            return "/promotion-service/api/YCDC/Detail"
        case .searchVanDon(_):
            return "/promotion-service/api/VanDon/Search"
        case .approveVanDon(_):
            return "/promotion-service/api/VanDon/Approve"
        case .nhaVanChuyen:
            return "/promotion-service/api/VanDon/NhaVanChuyen"
        case .searchShop:
            return "/promotion-service/api/VanDon/Masterdata/Shop"
        case .masterdataWhs:
            return "/promotion-service/api/YCDC/Masterdata/Whs"
        case .checkSOBH:
            return "/promotion-service/api/YCDC/CheckSOBH"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login,.sp_mpos_FRT_SP_GetNotify_oneapp,.sp_mpos_FRT_SP_delete_notify,.sp_mpos_FRT_SP_notify_update,.checkUserCheckInV2,.checkUserCheckOut,.getListShiftDate,.insertCheckIn,.insertCheckOut,.searchContacts,.mpos_sp_GateWay_GetInfoLogin,.require_sso_token,.getOTP, .mpos_FRT_Call_Customer_UpdateInfo,.tokenAD,.gateway_login, .gnnbv2_ScanQRCodeVerify, .gnnbv2_ScanQRCode, .gnnbv2_GenQRCodeImg, .gnnbv2_UnBookBill, .gnnbv2_UnBookListBill,.checkWhs,.createYCDC,.searchYCDC,.cancelYCDC,.approledYCDC,.detailYCDC,.searchVanDon,.approveVanDon,.checkSOBH:
            return .post
        case .registerDeviceToken,.removeDeviceToken,.checkVersion,.sp_mpos_FRT_SP_oneapp_CheckMenu,.checkOTP,.sp_mpos_FRT_SP_Check_quyen_gen_otp_getway,.mpos_FRT_SP_authen_get_list_shop_by_user, .mpos_FRT_Call_Customer_GetData,.userInfoAD, .gnnbv2_GetTransport,.nhaVanChuyen,.searchShop,.masterdataWhs:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .login(UserName,Password,CRMCode,SysType):
            return .requestParameters(parameters: ["UserName": UserName, "Password": Password,"CRMCode":CRMCode,"SysType":SysType], encoding: JSONEncoding.default)
        case .checkVersion:
            return .requestParameters(parameters: ["Devicetype":"2"], encoding: URLEncoding.queryString)
        case let .registerDeviceToken(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .removeDeviceToken(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_GetNotify_oneapp(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .sp_mpos_FRT_SP_delete_notify(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .sp_mpos_FRT_SP_notify_update(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .checkUserCheckInV2(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .checkUserCheckOut(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .getListShiftDate(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .insertCheckIn(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .insertCheckOut(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .sp_mpos_FRT_SP_oneapp_CheckMenu(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .searchContacts(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .checkOTP(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .getOTP(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case let .mpos_sp_GateWay_GetInfoLogin(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
 
        case let .require_sso_token(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .mpos_FRT_SP_authen_get_list_shop_by_user(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case let .mpos_FRT_Call_Customer_GetData(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Call_Customer_UpdateInfo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .tokenAD:
            return .requestParameters(parameters: [:], encoding:  JSONEncoding.default)
        case let .gateway_login(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .userInfoAD:
            return .requestParameters(parameters: [:], encoding:  URLEncoding.queryString)
        case let .gnnbv2_GetTransport(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .gnnbv2_ScanQRCodeVerify(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .gnnbv2_ScanQRCode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .gnnbv2_GenQRCodeImg(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .gnnbv2_UnBookBill(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .gnnbv2_UnBookListBill(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .checkWhs(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .createYCDC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .searchYCDC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .cancelYCDC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .approledYCDC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .detailYCDC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .searchVanDon(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .approveVanDon(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case .nhaVanChuyen,.searchShop:
            return .requestPlain
        case let .masterdataWhs(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .checkSOBH(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        var access_token = APIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        
        switch self {
        case .tokenAD,.gateway_login:
            return ["Content-Type": "application/json"]
        case .gnnbv2_GetTransport, .gnnbv2_ScanQRCodeVerify, .gnnbv2_ScanQRCode, .gnnbv2_GenQRCodeImg, .gnnbv2_UnBookBill, .gnnbv2_UnBookListBill:
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        default:
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        }
        
    }
    var sampleData: Data {
        return Data()
    }
}
