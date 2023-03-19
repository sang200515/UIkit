//
//  ProductAPIService.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

import Alamofire
enum CRMAPIService {
    //Galaxy
    case Galaxy_info_customer(params: [String: String])
    case Galaxy_order_insert(params: [String: String])
    case Galaxy_order_history(params: [String: String])
    case Galaxy_order_detais(params: [String: String])
    
    case GetSurveyQuestion(params: [String: String])
    case Survey_SaveData(jsonBatch: Data)
  
    //laptop-birthday
    case uploadImageUrl(params: [String: String])
    case sp_FRT_Voucher_Birthday_History(params: [String: String])
    case sp_FRT_Voucher_Birthday_Create(params: [String: String])
    case sp_FRT_Voucher_Birthday_Cancel(params: [String: String])

    //Mobifone Msale
    case mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(params: [String: String])
    case mpos_FRT_Mobifone_Msale_ActiveSim_Getlist(params: [String: String])
    case mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(params: [String: String])
    //Viettel Msale
    case mpos_FRT_Vietel_Msale_ActiveSim_Getlist(params: [String: String])
    case mpos_FRT_Vietel_Msale_ActiveSim_Confirm(params: [String: String])
    case checkPemissionMoMo(params:[String:String])

    //new chamcong
    case CheckIn_FirstLogin(params: [String: String])
    case GetListShiftDateByEmployee(params: [String: String])
    
    //esim itel
    //update itel
    case Itel_SendOTPUpdate(params: [String: String])
    case Itel_ChangeIsim(params: [String: String])
    case Itel_GetQrCode(params: [String: String])
    case Itel_GetChangeSimFee(params: [String: String])
    case Itel_GetUpdateSubInfoHistory(params: [String: String])
    //new checkin PG
    case PG_loadcheckinbywarehouse(params: [String: String])
    case PG_loadinfopg(params: [String: String])
    case PG_sendpasswordpg(params: [String: String])
    case PG_loadcheckinbypersonalid(params: [String: String])
    case PG_pgoffnhanvien(params: [String: String])
    // Update VNM
    case Itel_UpdateSubscriberInfo(params: [String: String])
    case UpdateCustomerResult_HDItelecom(params: [String: String])
    //topup_mobifone
    case Mobifone_GetlistTopup(params: [String: String])
    //ViettelPay_SOM
    case ViettelPay_SOM_GetMainInfo(params: [String: String])
    case ViettelPay_SOM_CreateOrder(params: [String: Any])
    case ViettelPay_SOM_GetFee(params: [String: Any])
    case ViettelPay_SOM_GetOTP_NapChinhMinh(params: [String: Any])
    case ViettelPay_SOM_CheckOrderStatus(params: [String: String])
    case ViettelPay_SOM_GetOrderInfo(params: [String: String])
    case ViettelPay_SOM_GetHistory(params: [String: String])
    
    //ViettelVAS_SOM
    case ViettelVAS_GetMainInfo(params: [String: String])
    case ViettelVAS_GetListGoiCuoc(params: [String: String])
    case ViettelVAS_GetOTP(params: [String: String])
    case ViettelVAS_CreateOrder(params: [String: Any])
    case ViettelVAS_GetHistory(params: [String: String])
}
extension CRMAPIService: TargetType {
    private static var _defaults = UserDefaults.standard
    private static var _manager = Config.manager
    var baseURL: URL {
        switch self {
        
        case .Galaxy_info_customer, .Galaxy_order_insert, .Galaxy_order_history, .Galaxy_order_detais, .uploadImageUrl, .sp_FRT_Voucher_Birthday_History, .sp_FRT_Voucher_Birthday_Create, .sp_FRT_Voucher_Birthday_Cancel, .mpos_FRT_Mobifone_Msale_ActiveSim_Load_package, .mpos_FRT_Mobifone_Msale_ActiveSim_Getlist, .mpos_FRT_Mobifone_Msale_ActiveSim_Confirm,.mpos_FRT_Vietel_Msale_ActiveSim_Getlist, .mpos_FRT_Vietel_Msale_ActiveSim_Confirm,.checkPemissionMoMo, .Itel_SendOTPUpdate,.Itel_ChangeIsim,.Itel_GetQrCode, .Itel_GetChangeSimFee, .Itel_GetUpdateSubInfoHistory, .UpdateCustomerResult_HDItelecom, .Itel_UpdateSubscriberInfo, .Mobifone_GetlistTopup:

            return URL(string: "\(CRMAPIService._manager.URL_GATEWAY!)")!
            
        case .GetSurveyQuestion, .Survey_SaveData, .CheckIn_FirstLogin, .GetListShiftDateByEmployee, .PG_loadcheckinbywarehouse, .PG_loadinfopg, .PG_sendpasswordpg, .PG_loadcheckinbypersonalid, .PG_pgoffnhanvien, .ViettelPay_SOM_GetMainInfo, .ViettelPay_SOM_CreateOrder, .ViettelPay_SOM_GetFee, .ViettelPay_SOM_GetOTP_NapChinhMinh, .ViettelPay_SOM_CheckOrderStatus, .ViettelPay_SOM_GetOrderInfo, .ViettelPay_SOM_GetHistory, .ViettelVAS_GetMainInfo, .ViettelVAS_GetListGoiCuoc, .ViettelVAS_GetOTP, .ViettelVAS_CreateOrder, .ViettelVAS_GetHistory:
            
            return URL(string: "\(CRMAPIService._manager.URL_GATEWAY!)")!
            
        }
        
    }
    var path: String {
        switch self {
        
        case .Galaxy_info_customer(_):
            return "/mpos-cloud-api/api/galaxyplay/info_customer"
        case .Galaxy_order_insert(_):
            return "/mpos-cloud-api/api/galaxyplay/order_insert"
        case .Galaxy_order_history(_):
            return "/mpos-cloud-api/api/galaxyplay/order_history"
        case .Galaxy_order_detais(_):
            return "/mpos-cloud-api/api/galaxyplay/order_detais"
        case .GetSurveyQuestion(_):
            return "/internal-api-service/api/inside/GetSurveyQuestion"
        case .Survey_SaveData(_):
            return "/internal-api-service/api/inside/Survey_SaveData"
        case .uploadImageUrl(_):
            return "/mpos-cloud-api/api/upload/file"
        case .sp_FRT_Voucher_Birthday_History(_):
            return "/mpos-cloud-api/api/customer/sp_FRT_Voucher_Birthday_History"
        case .sp_FRT_Voucher_Birthday_Create(_):
            return "/mpos-cloud-api/api/customer/sp_FRT_Voucher_Birthday_Create"
        case .sp_FRT_Voucher_Birthday_Cancel(_):
            return "/mpos-cloud-api/api/customer/sp_FRT_Voucher_Birthday_Cancel"
        case .mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(_):
            return "/mpos-cloud-api/api/Sim/mpos_FRT_Mobifone_Msale_ActiveSim_Load_package"
        case .mpos_FRT_Vietel_Msale_ActiveSim_Getlist,.mpos_FRT_Mobifone_Msale_ActiveSim_Getlist:
            return "/mpos-cloud-api/api/Sim/mpos_FRT_ActiveSim_GetList"
        case .mpos_FRT_Vietel_Msale_ActiveSim_Confirm,.mpos_FRT_Mobifone_Msale_ActiveSim_Confirm:
            return "/mpos-cloud-api/api/Sim/mpos_FRT_ActiveSim_ConfirmSO"
        case .checkPemissionMoMo(_):
            return "/mpos-cloud-api/api/momo/checkPemission"
        case .CheckIn_FirstLogin(_):
            return "/internal-api-service/api/inside/CheckIn_FirstLogin"
        case .GetListShiftDateByEmployee(_):
            return "/internal-api-service/api/inside/GetListShiftDateByEmployee"
        case .Itel_SendOTPUpdate(_):
            return "/mpos-cloud-api/api/Sim/Itel_SendOTPUpdate"
        case .Itel_ChangeIsim(_):
            return "/mpos-cloud-api/api/Sim/Itel_ChangeIsim"
        case .Itel_GetQrCode(_):
            return "/mpos-cloud-api/api/Sim/Itel_GetQrCode"
        case .Itel_GetChangeSimFee(_):
            return "/mpos-cloud-api/api/Sim/Itel_GetChangeSimFee"
        case .Itel_UpdateSubscriberInfo(_):
            return "/mpos-cloud-api/api/Sim/Itel_UpdateSubscriberInfo"
        case .Itel_GetUpdateSubInfoHistory(_):
            return "/mpos-cloud-api/api/Sim/Itel_GetUpdateSubInfoHistory"
        case .UpdateCustomerResult_HDItelecom(_):
            return "/mpos-cloud-api/api/ImgActiveSim/UpdateCustomerResult_HDItelecom"
        case .PG_loadcheckinbywarehouse(_):
            return "/internal-api-service/api/training/loadcheckinbywarehouse"
        case .PG_loadinfopg(_):
            return "/internal-api-service/api/training/loadinfopg"
        case .PG_sendpasswordpg(_):
            return "/internal-api-service/api/training/sendpasswordpg"
        case .PG_loadcheckinbypersonalid(_):
            return "/internal-api-service/api/training/loadcheckinbypersonalid"
        case .PG_pgoffnhanvien(_):
            return "/internal-api-service/api/training/pgoffnhanvien"
        case .Mobifone_GetlistTopup(_):
            return "/mpos-cloud-api/api/sim/Mobifone_GetlistTopup"
        case .ViettelPay_SOM_GetMainInfo(_):
            return "/som-product-service/api/Product/v1/Products/79ef7a15-eefe-4d6d-a816-90df86cd0ad3"
        case .ViettelPay_SOM_CreateOrder(_):
            return "/som-order-service/api/Order/v1/order"
        case .ViettelPay_SOM_GetFee(_):
            return "/som-integration-service/api/integration/v1/info"
        case .ViettelPay_SOM_GetOTP_NapChinhMinh(_):
            return "/som-integration-service/api/integration/v1/info"
        case .ViettelPay_SOM_CheckOrderStatus(_):
            return "/som-order-service/api/Order/v1/order/status"
        case .ViettelPay_SOM_GetOrderInfo(_):
            return "/som-order-service/api/Order/v1/order"
        case .ViettelPay_SOM_GetHistory(_):
            return "/som-search-service/api/Search/v1/Order/Filter"
            
        case .ViettelVAS_GetMainInfo(_):
            return "/som-product-service/api/Product/v1/Categories"
        case .ViettelVAS_GetListGoiCuoc(_):
            return "/som-integration-service/api/integration/v1/viettel/tvbh-vas/get-offers"
        case .ViettelVAS_GetOTP(_):
            return "/som-integration-service/api/integration/v1/viettel/tvbh-vas/send-otp"
        case .ViettelVAS_CreateOrder(_):
            return "/som-order-service/api/Order/v1/order"
        case .ViettelVAS_GetHistory(_):
            return "/som-search-service/api/Search/v1/Order/Filter"
        }
    }
    var method: Moya.Method {
        switch self {
        
        case .Galaxy_info_customer, .Galaxy_order_history, .Galaxy_order_detais, .GetSurveyQuestion, .mpos_FRT_Mobifone_Msale_ActiveSim_Load_package, .mpos_FRT_Mobifone_Msale_ActiveSim_Getlist,.mpos_FRT_Vietel_Msale_ActiveSim_Getlist, .CheckIn_FirstLogin, .GetListShiftDateByEmployee, .PG_loadcheckinbywarehouse, .PG_loadinfopg, .PG_loadcheckinbypersonalid, .PG_sendpasswordpg, .PG_pgoffnhanvien, .ViettelPay_SOM_GetMainInfo, .ViettelPay_SOM_CheckOrderStatus, .ViettelPay_SOM_GetOrderInfo, .ViettelPay_SOM_GetHistory, .Mobifone_GetlistTopup, .ViettelVAS_GetMainInfo, .ViettelVAS_GetHistory:
            
            return .get

        case .Galaxy_order_insert, .Survey_SaveData, .uploadImageUrl, .sp_FRT_Voucher_Birthday_History, .sp_FRT_Voucher_Birthday_Create, .sp_FRT_Voucher_Birthday_Cancel, .mpos_FRT_Mobifone_Msale_ActiveSim_Confirm,.mpos_FRT_Vietel_Msale_ActiveSim_Confirm,.checkPemissionMoMo, .Itel_SendOTPUpdate,.Itel_ChangeIsim,.Itel_GetQrCode, .Itel_GetChangeSimFee, .Itel_GetUpdateSubInfoHistory, .ViettelPay_SOM_CreateOrder, .ViettelPay_SOM_GetFee, .ViettelPay_SOM_GetOTP_NapChinhMinh, .UpdateCustomerResult_HDItelecom, .Itel_UpdateSubscriberInfo, .ViettelVAS_GetListGoiCuoc, .ViettelVAS_GetOTP, .ViettelVAS_CreateOrder:
            
            return .post
        }
    }
    var task: Task {
        switch self {
            
        case let .Galaxy_info_customer(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Galaxy_order_insert(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Galaxy_order_history(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Galaxy_order_detais(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .GetSurveyQuestion(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .Survey_SaveData(jsonBatch):
            return .requestCompositeData(bodyData: jsonBatch, urlParameters: ["company":"Fptshop", "EmployeeCode":"\(Cache.user?.UserName ?? "")"])
        case let .uploadImageUrl(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_FRT_Voucher_Birthday_History(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_FRT_Voucher_Birthday_Create(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .sp_FRT_Voucher_Birthday_Cancel(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mobifone_Msale_ActiveSim_Getlist(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Vietel_Msale_ActiveSim_Getlist(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .mpos_FRT_Vietel_Msale_ActiveSim_Confirm(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .checkPemissionMoMo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .CheckIn_FirstLogin(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .GetListShiftDateByEmployee(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .Itel_SendOTPUpdate(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Itel_ChangeIsim(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Itel_GetQrCode(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Itel_GetChangeSimFee(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Itel_GetUpdateSubInfoHistory(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .PG_loadcheckinbywarehouse(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PG_loadinfopg(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PG_sendpasswordpg(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PG_loadcheckinbypersonalid(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .PG_pgoffnhanvien(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .Mobifone_GetlistTopup(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)

        case let .ViettelPay_SOM_GetMainInfo(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .ViettelPay_SOM_CreateOrder(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_SOM_GetFee(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_SOM_GetOTP_NapChinhMinh(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelPay_SOM_CheckOrderStatus(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .ViettelPay_SOM_GetOrderInfo(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .ViettelPay_SOM_GetHistory(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .Itel_UpdateSubscriberInfo(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .UpdateCustomerResult_HDItelecom(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .ViettelVAS_GetMainInfo(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .ViettelVAS_GetListGoiCuoc(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelVAS_GetOTP(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelVAS_CreateOrder(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .ViettelVAS_GetHistory(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        var access_token = CRMAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let access_toke_beta = UserDefaults.standard.getMyInfoToken()
        
        switch self {
        
        case .Galaxy_info_customer, .Galaxy_order_insert, .Galaxy_order_history, .Galaxy_order_detais, .uploadImageUrl, .sp_FRT_Voucher_Birthday_History, .sp_FRT_Voucher_Birthday_Create, .sp_FRT_Voucher_Birthday_Cancel, .mpos_FRT_Mobifone_Msale_ActiveSim_Load_package, .mpos_FRT_Mobifone_Msale_ActiveSim_Getlist, .mpos_FRT_Mobifone_Msale_ActiveSim_Confirm,.mpos_FRT_Vietel_Msale_ActiveSim_Confirm,.mpos_FRT_Vietel_Msale_ActiveSim_Getlist,.checkPemissionMoMo, .Itel_SendOTPUpdate,.Itel_ChangeIsim,.Itel_GetQrCode, .Itel_GetChangeSimFee, .Itel_GetUpdateSubInfoHistory, .Itel_UpdateSubscriberInfo, .UpdateCustomerResult_HDItelecom, .Mobifone_GetlistTopup:

            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .GetSurveyQuestion, .CheckIn_FirstLogin, .GetListShiftDateByEmployee,.PG_loadcheckinbywarehouse, .PG_loadinfopg, .PG_sendpasswordpg, .PG_loadcheckinbypersonalid, .PG_pgoffnhanvien, .ViettelPay_SOM_GetMainInfo, .ViettelPay_SOM_CreateOrder, .ViettelPay_SOM_GetFee, .ViettelPay_SOM_GetOTP_NapChinhMinh, .ViettelPay_SOM_CheckOrderStatus, .ViettelPay_SOM_GetOrderInfo, .ViettelPay_SOM_GetHistory, .ViettelVAS_GetMainInfo, .ViettelVAS_GetListGoiCuoc, .ViettelVAS_GetOTP, .ViettelVAS_CreateOrder, .ViettelVAS_GetHistory:
       
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
            
        case .Survey_SaveData:
            return  ["Content-type": "application/json-patch+json","Authorization": "Bearer \(access_token!)"]
        }
        
        
        
        
    }
    
    
    
    
    var sampleData: Data {
        return Data()
    }
    
    
    
    
}
