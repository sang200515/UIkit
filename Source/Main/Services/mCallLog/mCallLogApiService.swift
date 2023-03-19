//
//  mCallLogApiService.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 14/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import Moya;

enum mCallLogApiService{
    //Login
    case Login(username: String, password: String);
    
    //CallLog
    case GetCallLogs(username: String, token: String);
    case GetCallLogCamera(isBetaBranch: Int, username: String);
    case PostCallLogUpdate(callLogId: String, username: String, message: String, approvation: Int, token: String);
    case GetCallLogCameraDetails(isBetaBranch: Int, requestId: String);
    case GetCallLogStepChanging(isBetaBranch: Int, callLogId: Int, action:String, message: String, username: String);
    case PostCameraCallLogApprovation(isBetaBranch: Int, requestId: Int, requestDetailsId: String, requestDetailsApprovation: Int, requestViolatedEmployee: String);
    case GetAppearanceCallLogDetails(requestId: String, username: String, token: String);
    case PostImage(imageName: String, encodedImage: String, username: String);
    case PostChangingStep(requestId: String, message: String, updatedBy: String, urlDefectiveProductImg: String, urlPackageImg: String, username: String, token: String);
    
    //We Love
    case GetPermission(username: String, token: String);
    case GetEvaluationCriteria(parentId: String, token: String, username: String);
    case GetEvaluationDepartment(token: String, username: String);
    case PostRequest(evaluationType: String, evaluationDepartment: String, evaluationCriteria: String, requestDetails: String, updatedBy :String, token: String, username: String)
    
    //Bill Van Chuyen
    case Bill__LoadTitle(params: [String: String])
    case Bill__LoadCC(params: [String: String])
    case Bill__LoadDiaChiGui(params: [String: String])
    case Bill__LoadTinhThanhPho(params: [String: String])
    case Bill__LoadQuanHuyen(params: [String: String])
    case Bill__LoadShopPhongBan(params: [String: String])
    case Bill__LoadDiaChiNhan(params: [String: String])
    case Bill__LoadLoaiHang(params: [String: String])
    case Bill__LoadNhaVanChuyen(params: [String: String])
    case Bill__LoadDichVu(params: [String: String])
    case Bill__LoadHinhThucThanhToan(params: [String: String])
    case Bill__LoadDiaChiNhanGanDay(params: [String: String])
    case Bill__CreateBill(params: [String: String])
    case Bill__KiemTraThongTinUser(params: [String: String])
    case Bill__CancelBill(params: [String: String])

    //CL Xuatdemo
    case DemoReq__GetHeader_ByReqId(params: [String: String])
    case DemoReq__GetDetail_ByReqId(params: [String: String])
    case DemoReq__GetConv_ByReqId(params: [String: String])
    case DemoReq__XuLy(params: [String: String])
    
    //CL DuyetLoiDOA
    case DuyetLoiDOA_213_LoadConv(params: [String: String])
    case DuyetLoiDOA_213_LoadDetail(params: [String: String])
    case DuyetLoiDOA_213_SaveImgUrl(params: [String: String])
    
    //Duyet cong no VNPT
    case DuyetCongNoVNPTReq__GetDetail_ByReqId(params: [String: String])
    case DuyetCongNoVNPTReq__XuLy(params: [String: String])
    
    //Duyet han muc the cao
    case DuyetHanMucTheCao_TypeId_226_GetDetail(params: [String: String])
    case DuyetHanMucTheCao_TypeId_226_GetConv(params: [String: String])
    case DuyetHanMucTheCao_TypeId_226_PushConv(params: [String: String])
    case DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(params: [String: String])
    //FEC
    case TypeId_227_GetDetail(params: [String: String])
    //posm
    case mCallLog_DanhSachCongViec_GetRequest(params: [String: String])
    case TypeId_229_GetDetail(params: [String: String])
    case TypeId_229_UploadImage(params: [String: String])
    case TypeId_229_XuLy(params: [String: Any])
    //Calllog báo lỗi kích hoạt sim
    case Calllog_FRTUService_AttachFile_Upload(params: [String: String])
    case Calllog_FRTUService_Ticket_Create(params: [String: String])
}

extension mCallLogApiService: TargetType{
    private static var _defaults = UserDefaults.standard
    
    var baseURL: URL {
        switch self {
        case .Login,
             .GetCallLogs,
             .GetPermission,
             .GetEvaluationCriteria,
             .GetEvaluationDepartment,
             .PostRequest,
             .PostCallLogUpdate,
             .GetAppearanceCallLogDetails,
             .PostChangingStep,
             .Bill__LoadTitle,
             .Bill__LoadCC,
             .Bill__LoadDiaChiGui,
             .Bill__LoadTinhThanhPho,
             .Bill__LoadQuanHuyen,
             .Bill__LoadShopPhongBan,
             .Bill__LoadDiaChiNhan,
             .Bill__LoadLoaiHang,
             .Bill__LoadNhaVanChuyen,
             .Bill__LoadDichVu,
             .Bill__LoadHinhThucThanhToan,
             .Bill__LoadDiaChiNhanGanDay,
             .Bill__CreateBill,
             .Bill__KiemTraThongTinUser,
             .Bill__CancelBill,
             .DemoReq__GetHeader_ByReqId,
             .DemoReq__GetDetail_ByReqId,
             .DemoReq__GetConv_ByReqId,
             .DemoReq__XuLy,
             .DuyetLoiDOA_213_LoadConv,
             .DuyetLoiDOA_213_LoadDetail,
             .DuyetLoiDOA_213_SaveImgUrl,
             .DuyetCongNoVNPTReq__GetDetail_ByReqId,
             .DuyetCongNoVNPTReq__XuLy,
             .DuyetHanMucTheCao_TypeId_226_GetDetail,
             .DuyetHanMucTheCao_TypeId_226_GetConv,
             .DuyetHanMucTheCao_TypeId_226_PushConv,
             .DuyetHanMucTheCao_TypeId_226_DuyetHanMuc,
             .TypeId_227_GetDetail,
             .mCallLog_DanhSachCongViec_GetRequest,
             .TypeId_229_GetDetail,
             .TypeId_229_UploadImage,
             .TypeId_229_XuLy:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-callog")!;
        case .GetCallLogCamera:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-callogapi")!;
        case .GetCallLogCameraDetails,
             .GetCallLogStepChanging,
             .PostCameraCallLogApprovation:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-calloginside/api")!;
        case .PostImage:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-callog")!;
        case .Calllog_FRTUService_AttachFile_Upload, .Calllog_FRTUService_Ticket_Create:
            return URL(string: Config.manager.URL_GATEWAY)!
        }
    }
    
    var path: String {
        switch self{
        case .Login:
            return "/mCallLog/Service.svc/Login";
        case .GetPermission:
            return "/mCallLog/Service.svc/WeLoveNoiBo_Get_PhanQuyen";
        case .GetEvaluationCriteria:
            return "/mCallLog/Service.svc/WeLoveNoiBo_Get_TieuChiDanhGia";
        case .GetEvaluationDepartment:
            return "/mCallLog/Service.svc/WeLoveNoiBo_Get_BoPhanDanhGia";
        case .PostRequest:
            return "/mCallLog/Service.svc/WeLoveNoiBo_Create_Request";
        case .GetCallLogs:
//            return "/MCallLog/Service.svc/getUserCallLogs";
            return "/MCallLog/Service.svc/GetRequest";
        case .GetCallLogCamera:
            return "/Mobile/Mobile_CallLog_GiamSatHinhAnhCamera_Get";
        case .PostCallLogUpdate:
            return "/MCallLog/Service.svc/ProcessingRequest";
        case .GetCallLogCameraDetails:
            return "/Mobile/Mobile_CallLog_GiamSatHinhAnhCamera_GetDetail";
        case .GetCallLogStepChanging:
            return "/MCallLog/Service.svc/Mobile_CallLog_DuyetLoiThamMy_UpHinh";
        case .PostCameraCallLogApprovation:
            return "/Mobile/Mobile_CallLog_GiamSatHinhAnhCamera_ApproveDetail";
        case .GetAppearanceCallLogDetails:
            return "/MCallLog/Service.svc/Mobile_CallLog_DuyetLoiThamMy_GetDetail";
        case .PostImage:
            return "/Uploads/Uploads_FileAttachs";
        case .PostChangingStep:
            return "/MCallLog/Service.svc/Mobile_CallLog_DuyetLoiThamMy_UpHinh";
            
        //Bill Van Chuyen
        case .Bill__LoadTitle:
            return "/mCallLog/Service.svc/Bill__LoadTitle"
        case .Bill__LoadCC:
            return "/mCallLog/Service.svc/Bill__LoadCC"
        case .Bill__LoadDiaChiGui:
            return "/mCallLog/Service.svc/Bill__LoadDiaChiGui"
        case .Bill__LoadTinhThanhPho:
            return "/mCallLog/Service.svc/Bill__LoadTinhThanhPho"
        case .Bill__LoadQuanHuyen:
            return "/mCallLog/Service.svc/Bill__LoadQuanHuyen"
        case .Bill__LoadShopPhongBan:
            return "/mCallLog/Service.svc/Bill__LoadShopPhongBan"
        case .Bill__LoadDiaChiNhan:
            return "/mCallLog/Service.svc/Bill__LoadDiaChiNhan"
        case .Bill__LoadLoaiHang:
            return "/mCallLog/Service.svc/Bill__LoadLoaiHang"
        case .Bill__LoadNhaVanChuyen:
            return "/mCallLog/Service.svc/Bill__GetPhanTuyen"
        case .Bill__LoadDichVu:
            return "/mCallLog/Service.svc/Bill__LoadHinhThucVanChuyenPOS"
        case .Bill__LoadHinhThucThanhToan:
            return "/mCallLog/Service.svc/Bill__LoadHinhThucThanhToan"
        case .Bill__LoadDiaChiNhanGanDay:
            return "/mCallLog/Service.svc/Bill__LoadDiaChiNhanGanDay"
        case .Bill__CreateBill:
            return "/mCallLog/Service.svc/Bill__CreateBill"
        case .Bill__KiemTraThongTinUser:
            return "/mCallLog/Service.svc/Bill__KiemTraThongTinUser"
        case .Bill__CancelBill:
            return "/mCallLog/Service.svc/Bill__CancelBill"
            
        //CL Xuatdemo
        case .DemoReq__GetHeader_ByReqId:
            return "/mCallLog/Service.svc/DemoReq__GetHeader_ByReqId"
        case .DemoReq__GetDetail_ByReqId:
            return "/mCallLog/Service.svc/DemoReq__GetDetail_ByReqId"
        case .DemoReq__GetConv_ByReqId:
            return "/mCallLog/Service.svc/DemoReq__GetConv_ByReqId"
        case .DemoReq__XuLy:
            return "/mCallLog/Service.svc/DemoReq__XuLy"
            
            //CL Duye loi DOA
        case .DuyetLoiDOA_213_LoadConv:
            return "/mCallLog/Service.svc/DuyetLoiDOA_213_LoadConv"
        case .DuyetLoiDOA_213_LoadDetail:
            return "/mCallLog/Service.svc/DuyetLoiDOA_213_LoadDetail"
        case .DuyetLoiDOA_213_SaveImgUrl:
            return "/mCallLog/Service.svc/DuyetLoiDOA_213_SaveImgUrl"
            
        //Duyet cong no VNPT
        case .DuyetCongNoVNPTReq__GetDetail_ByReqId:
            return "/mCallLog/Service.svc/DuyetCongNoVNPTReq__GetDetail_ByReqId"
        case .DuyetCongNoVNPTReq__XuLy:
            return "/mCallLog/Service.svc/DuyetCongNoVNPTReq__XuLy"
            
        //Duyet han muc the cao
        case .DuyetHanMucTheCao_TypeId_226_GetDetail:
            return "/mCallLog/Service.svc/TypeId_226_GetDetail"
        case .DuyetHanMucTheCao_TypeId_226_GetConv:
            return "/mCallLog/Service.svc/TypeId_226_GetConv"
        case .DuyetHanMucTheCao_TypeId_226_PushConv:
            return "/mCallLog/Service.svc/TypeId_226_PushConv"
        case .DuyetHanMucTheCao_TypeId_226_DuyetHanMuc:
            return "/mCallLog/Service.svc/TypeId_226_DuyetHanMuc"
        case .TypeId_227_GetDetail:
            return "/mCallLog/Service.svc/TypeId_227_GetDetail"
        case .mCallLog_DanhSachCongViec_GetRequest:
            return "/mCallLog/Service.svc/mCallLog_DanhSachCongViec_GetRequest"
        case .TypeId_229_GetDetail:
            return "/mCallLog/Service.svc/TypeId_229_GetDetail"
        case .TypeId_229_UploadImage:
            return "/mCallLog/Service.svc/TypeId_229_UploadImage"
        case .TypeId_229_XuLy:
            return "/mCallLog/Service.svc/TypeId_229_XuLy"
        case .Calllog_FRTUService_AttachFile_Upload:
            return "/internal-api-service/api/frt-uservice/FRTUService_AttachFile_Upload"
        case .Calllog_FRTUService_Ticket_Create:
            return "/internal-api-service/api/frt-uservice/FRTUService_Ticket_Create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetCallLogCamera,
             .GetCallLogCameraDetails,
             .GetCallLogStepChanging,
             .PostCameraCallLogApprovation:
            return .get;
        default:
            return .post;
        }
    }
    
    var sampleData: Data {
        return Data();
    }
    
    var task: Task {
        switch self {
        case .Login(let username, let password):
            return .requestParameters(parameters: ["p_UserName": username, "p_Password": password], encoding: JSONEncoding.default);
        case .GetCallLogs(let username, let token):
            return .requestParameters(parameters: ["p_EmployeeCode":username, "p_Type": "0", "p__UserCode": username, "p__Token": token], encoding: JSONEncoding.default)
        case .GetCallLogCamera(let isBetaBranch, let username):
            return .requestParameters(parameters: ["p_IsBeta": isBetaBranch, "p_User": username], encoding: URLEncoding.default);
        case .PostCallLogUpdate(let callLogId, let username, let message, let approvation, let token):
            return .requestParameters(parameters: ["p_RequestId": callLogId, "p_EmployeeCode": username, "p_Message": message, "p_Approved": approvation, "p__Token": token, "p__UserCode": username], encoding: JSONEncoding.default);
        case .GetCallLogCameraDetails(let isBetaBranch, let requestId):
            return .requestParameters(parameters: ["p_IsBeta" : isBetaBranch, "p_RequestId" : requestId], encoding: URLEncoding.default);
        case .GetCallLogStepChanging(let isBetaBranch, let callLogId, let action, let message, let username):
            return .requestParameters(parameters: ["p_IsBeta" : isBetaBranch, "p_RequestId" : callLogId, "p_ActionType" : action, "p_Message" : "\(message.replace(target: " ", withString: "%20"))", "p_User" : username], encoding: URLEncoding.default);
        case .PostCameraCallLogApprovation(let isBetaBranch, let requestId, let requestDetailsId, let requestDetailsApprovation, let requestViolatedEmployee):
            return .requestParameters(parameters: ["p_IsBeta" : isBetaBranch, "p_RequestId" : requestId, "p_RequestDetailId" : requestDetailsId, "p_RequestDetailApproved" : requestDetailsApprovation, "p_RequestDetailNVViPham" : requestViolatedEmployee], encoding: URLEncoding.default);
        case .GetAppearanceCallLogDetails(let requestId, let username, let token):
            return .requestParameters(parameters: ["p_RequestID": requestId, "p__UserCode": username, "p_UserCode": username, "p__Token": token], encoding: JSONEncoding.default);
        case .PostImage(let imageName, let encodedImage, let username):
            return .requestParameters(parameters: ["FileName":"\(imageName)","Base64String":"\(encodedImage)","UserCode":"\(username)"], encoding: JSONEncoding.default)
        case .PostChangingStep(let requestId, let message, let updatedBy, let urlDefectiveProductImg, let urlPackageImg, let username, let token):
            return .requestParameters(parameters: ["p_RequestID": "\(requestId)", "p_Message": "\(message)", "p_UpdateBy": "\(updatedBy)", "p_URL_HinhAnhMayLoi": "\(urlDefectiveProductImg)", "p_URL_HinhAnhVoHop": "\(urlPackageImg)", "p__UserCode": username, "p__Token": token], encoding: JSONEncoding.default);
            
        //We Love
        case .GetPermission(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p__UserCode": username, "p__Token": token], encoding: JSONEncoding.default);
        case .GetEvaluationCriteria(let parentId, let token, let username):
            return .requestParameters(parameters: ["p_ParentId": parentId, "p__Token": token, "p__UserCode": username], encoding: JSONEncoding.default);
        case .GetEvaluationDepartment(let token, let username):
            return .requestParameters(parameters: ["p__Token": token, "p__UserCode": username], encoding: JSONEncoding.default);
        case .PostRequest(let evaluationType, let evaluationDepartment, let evaluationCriteria, let requestDetails, let updatedBy, let token, let username):
            return .requestParameters(parameters: ["p_LoaiDanhGia" : evaluationType,"p_BoPhanDanhGia" : evaluationDepartment,"p_TieuChiDanhGia" : evaluationCriteria,"p_NoiDungChiTiet" : requestDetails,"p_UpdateBy" : updatedBy, "p__Token": token, "p__UserCode": username], encoding: JSONEncoding.default);
            
        //Bill Van Chuyen
        case let .Bill__LoadTitle(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadCC(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadDiaChiGui(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadTinhThanhPho(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadQuanHuyen(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadShopPhongBan(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadDiaChiNhan(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadLoaiHang(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadNhaVanChuyen(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadDichVu(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadHinhThucThanhToan(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__LoadDiaChiNhanGanDay(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__CreateBill(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__KiemTraThongTinUser(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .Bill__CancelBill(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
            
        //Cl xuat demo
        case let .DemoReq__GetHeader_ByReqId(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .DemoReq__GetDetail_ByReqId(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .DemoReq__GetConv_ByReqId(param):
            return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
        case let .DemoReq__XuLy(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            //CL Duyetloi DOA
        case let .DuyetLoiDOA_213_LoadConv(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetLoiDOA_213_LoadDetail(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetLoiDOA_213_SaveImgUrl(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        //Duyet comg no VNPT
        case let .DuyetCongNoVNPTReq__GetDetail_ByReqId(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetCongNoVNPTReq__XuLy(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        //Duyet han muc the cao
        case let .DuyetHanMucTheCao_TypeId_226_GetDetail(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetHanMucTheCao_TypeId_226_GetConv(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetHanMucTheCao_TypeId_226_PushConv(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        //FEC
        case let .TypeId_227_GetDetail(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        //posm
        case let .mCallLog_DanhSachCongViec_GetRequest(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .TypeId_229_GetDetail(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .TypeId_229_UploadImage(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .TypeId_229_XuLy(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        //calllog báo lỗi kích hoạt sim
        case let .Calllog_FRTUService_AttachFile_Upload(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case let .Calllog_FRTUService_Ticket_Create(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            var access_token = UserDefaults.standard.string(forKey: "access_token")
            access_token = access_token == nil ? "" : access_token
            
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        }
    }
}
