//
//  mCallLogApiManager.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 14/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import Moya;
import SwiftyJSON;

class mCallLogApiManager{
    
    public static func GetLoginInfo(username: String, password: String) -> Response<mCallLogUser>{
        let returnedData = Response<mCallLogUser>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "mCallLog_sp_AuthenticateResult", target: .Login(username: username, password: password), mappingObj: mCallLogUser.self) { (data, err) in
            let checkingResult = data as? mCallLogUser;
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetCameraCallLogs(isBetaBranch: Int, username: String) -> Response<[CallLog]>{
        let returnedData = Response<[CallLog]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "Request_Title", target: .GetCallLogCamera(isBetaBranch: isBetaBranch, username: username ), mappingObj: CallLog.self) { (data, err) in
            let checkingResult = data as? [CallLog];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetAppearanceCallLogDetails(requestId: String, username: String, token: String) -> Response<[AppearanceCallLog]> {
        let returnedData = Response<[AppearanceCallLog]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_Mobile_CallLog_DuyetLoiThamMy_GetDetailResult", target: .GetAppearanceCallLogDetails(requestId: requestId, username: username, token: token), mappingObj: AppearanceCallLog.self) { (data, err) in
            let checkingResult = data as? [AppearanceCallLog];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetCallLogList(username: String, token: String) -> Response<[CallLog]>{
        let returnedData = Response<[CallLog]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "mCallLog_sp_GetRequestResult", target: .GetCallLogs(username: username, token: token), mappingObj: CallLog.self) { (data, err) in
            let checkingResult = data as? [CallLog];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func PostCallLogUpdate(callLogId: String, username: String, message: String, approvation: Int, token: String) -> Response<CallLogUpdateResult>{
        let returnedData = Response<CallLogUpdateResult>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "mCallLog_sp_ProcessingRequestResult", target: .PostCallLogUpdate(callLogId: callLogId, username: username, message: message, approvation: approvation, token: token), mappingObj: CallLogUpdateResult.self) { (data, err) in
            let checkingResult = data as? CallLogUpdateResult;
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func PostChangingStep(requestId: String, message: String, updatedBy: String, urlDefectiveProductImg: String, urlPackageImg: String, username: String, token: String) -> Response<[CallLogUpdateResult]>{
        let returnedData = Response<[CallLogUpdateResult]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_Mobile_CallLog_DuyetLoiThamMy_UpHinhResult", target: .PostChangingStep(requestId: requestId, message: message, updatedBy: updatedBy, urlDefectiveProductImg: urlDefectiveProductImg, urlPackageImg: urlPackageImg, username: username, token: token), mappingObj: CallLogUpdateResult.self) { (data, err) in
            let checkingResult = data as? [CallLogUpdateResult];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func UploadImage(fileName: String, encodedImg: String, username: String) -> Response<ImageUploadResult>{
        let returnedData = Response<ImageUploadResult>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: nil, target: .PostImage(imageName: fileName, encodedImage: encodedImg, username: username), mappingObj: ImageUploadResult.self) { (data, err) in
            let checkingResult = data as? ImageUploadResult;
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetEvaluationCriteria(parentId: String, token: String, username: String) -> Response<[WeLoveEvaluation]>{
        let returnedData = Response<[WeLoveEvaluation]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_WeLoveNoiBo_Get_TieuChiDanhGiaResult", target: .GetEvaluationCriteria(parentId: parentId, token: token, username: username), mappingObj: WeLoveEvaluation.self) { (data, err) in
            let checkingResult = data as? [WeLoveEvaluation];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetEvaluationDepartment(username: String, token: String) -> Response<[WeLoveEvaluation]>{
        let returnedData = Response<[WeLoveEvaluation]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_WeLoveNoiBo_Get_BoPhanDanhGiaResult", target: .GetEvaluationDepartment(token: token, username: username), mappingObj: WeLoveEvaluation.self) { (data, err) in
            let checkingResult = data as? [WeLoveEvaluation];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func PostRequest(evaluationType: String, evaluationDepartment: String, evaluationCriteria: String, requestDetails: String, updatedBy :String, token: String, username: String) -> Response<[WeLovePostRequestResult]>{
        let returnedData = Response<[WeLovePostRequestResult]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_WeLoveNoiBo_Create_RequestResult", target: .PostRequest(evaluationType: evaluationType, evaluationDepartment: evaluationDepartment, evaluationCriteria: evaluationCriteria, requestDetails: requestDetails, updatedBy: updatedBy, token: token, username: username), mappingObj: WeLovePostRequestResult.self) { (data, err) in
            let checkingResult = data as? [WeLovePostRequestResult];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func GetPermission(username: String, token: String) -> Response<[WeLovePermission]>{
        let returnedData = Response<[WeLovePermission]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_WeLoveNoiBo_Get_PhanQuyenResult", target: .GetPermission(username: username, token: token), mappingObj: WeLovePermission.self) { (data, err) in
            let checkingResult = data as? [WeLovePermission];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    private static func SendRequest(keyPath: String?, target: mCallLogApiService, mappingObj: Jsonable.Type, handler: @escaping(_ success: Any, _ error: String) -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        let apiProvider = MoyaProvider<mCallLogApiService>(plugins: [VerbosePlugin(verbose: true)]);
        
        apiProvider.request(target, callbackQueue: .global(qos: .background)){ result in
            var response: Any!;
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data;
                let json = try! JSON(data: data);
                
                
                if(keyPath == nil){
                    if let obj = json.to(type: mappingObj) {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                        response = obj;
                        handler(response as Any,"")
                    }
                    else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(response as Any,"Load API ERRO")
                    }
                }
                    
                else{
                    if let obj = json[keyPath!].to(type: mappingObj) {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                        response = obj;
                        handler(response as Any,"")
                    }
                    else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(response as Any,"Load API ERRO")
                    }
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(response as Any, error.localizedDescription)
            }
        }
    }
    
    //Bill Van Chuyen
    //    case Bill__LoadTitle(params: [String: String])
    public static func Bill__LoadTitle() -> Response<[BillLoadTitle]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "p_UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        let returnedData = Response<[BillLoadTitle]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadTitleResult", target: .Bill__LoadTitle(params: parameters), mappingObj: BillLoadTitle.self) { (data, err) in
            let checkingResult = data as? [BillLoadTitle];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //    case Bill__LoadCC(params: [String: String])
    public static func Bill__LoadCC() -> Response<[BillLoadCC]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        let returnedData = Response<[BillLoadCC]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadCCResult", target: .Bill__LoadCC(params: parameters), mappingObj: BillLoadCC.self) { (data, err) in
            let checkingResult = data as? [BillLoadCC];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    
    class func Bill__LoadTinhThanhPho(handler: @escaping (_ success:[BillLoadTinhThanhPho],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        
        var rs:[BillLoadTinhThanhPho] = []
        provider.request(.Bill__LoadTinhThanhPho(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["sp__mCallLog__Bill__LoadTinhThanhPhoResult"].array {
                    rs = BillLoadTinhThanhPho.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    
    class func Bill__LoadQuanHuyen(handler: @escaping (_ success:[BillLoadQuanHuyen],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        
        var rs:[BillLoadQuanHuyen] = []
        provider.request(.Bill__LoadQuanHuyen(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["sp__mCallLog__Bill__LoadQuanHuyenResult"].array {
                    rs = BillLoadQuanHuyen.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    
    class func Bill__LoadShopPhongBan(handler: @escaping (_ success:[BillLoadShopPhongBan],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        
        var rs:[BillLoadShopPhongBan] = []
        provider.request(.Bill__LoadShopPhongBan(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["sp__mCallLog__Bill__LoadShopPhongBanResult"].array {
                    rs = BillLoadShopPhongBan.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    
    class func Bill__LoadDiaChiNhan(p_MaShopPhongBan: String, handler: @escaping (_ success:[BillLoadDiaChiNhan],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "p_MaShopPhongBan": "\(p_MaShopPhongBan)"
        ]
        
        
        var rs:[BillLoadDiaChiNhan] = []
        provider.request(.Bill__LoadDiaChiNhan(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["sp__mCallLog__Bill__LoadDiaChiNhanResult"].array {
                    rs = BillLoadDiaChiNhan.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    
    //    case Bill__LoadLoaiHang(params: [String: String])
    public static func Bill__LoadLoaiHang() -> Response<[BillLoadLoaiHang]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        let returnedData = Response<[BillLoadLoaiHang]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadLoaiHangResult", target: .Bill__LoadLoaiHang(params: parameters), mappingObj: BillLoadLoaiHang.self) { (data, err) in
            let checkingResult = data as? [BillLoadLoaiHang];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //    case Bill__LoadNhaVanChuyen
    
//    public static func Bill__LoadNhaVanChuyen() -> Response<[BillLoadNhaVanChuyen]>{
//
//        let parameters: [String: String] = [
//            "p__UserCode": "\(Cache.user?.UserName ?? "")",
//            "p__Token": "\(Cache.user?.Token ?? "")"
//        ]
//        let returnedData = Response<[BillLoadNhaVanChuyen]>();
//        let dispatchGroup = DispatchGroup();
//        dispatchGroup.enter();
//
//        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadNhaVanChuyenResult", target: .Bill__LoadNhaVanChuyen(params: parameters), mappingObj: BillLoadNhaVanChuyen.self) { (data, err) in
//            let checkingResult = data as? [BillLoadNhaVanChuyen];
//            returnedData.Data = checkingResult;
//            returnedData.Error = err;
//            dispatchGroup.leave();
//        }
//
//        dispatchGroup.wait();
//
//        return returnedData;
//    }
    
    public static func Bill__LoadNhaVanChuyen(IdTinhDi: String, IdTinhDen: String, ShopDiB1: String, ShopDenB1: String, TrongLuong: String, DichVu: String) -> Response<[BillLoadNhaVanChuyen]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "IdTinhDi":"\(IdTinhDi)",
            "IdTinhDen":"\(IdTinhDen)",
            "ShopDiB1":"\(ShopDiB1)",
            "ShopDenB1":"\(ShopDenB1)",
            "TrongLuong":"\(TrongLuong)",
            "DichVu":"\(DichVu)"
        ]
        let returnedData = Response<[BillLoadNhaVanChuyen]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__GetPhanTuyenResult", target: .Bill__LoadNhaVanChuyen(params: parameters), mappingObj: BillLoadNhaVanChuyen.self) { (data, err) in
            let checkingResult = data as? [BillLoadNhaVanChuyen];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //    case Bill__LoadDichVu(params: [String: String])
//    public static func Bill__LoadDichVu(p_MaNhaVanChuyen: String) -> Response<[BillLoadDichVu]>{
//
//        let parameters: [String: String] = [
//            "p__UserCode": "\(Cache.user?.UserName ?? "")",
//            "p__Token": "\(Cache.user?.Token ?? "")",
//            "p_MaNhaVanChuyen": "\(p_MaNhaVanChuyen)"
//        ]
//        let returnedData = Response<[BillLoadDichVu]>();
//        let dispatchGroup = DispatchGroup();
//        dispatchGroup.enter();
//
//        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadDichVuResult", target: .Bill__LoadDichVu(params: parameters), mappingObj: BillLoadDichVu.self) { (data, err) in
//            let checkingResult = data as? [BillLoadDichVu];
//            returnedData.Data = checkingResult;
//            returnedData.Error = err;
//            dispatchGroup.leave();
//        }
//
//        dispatchGroup.wait();
//
//        return returnedData;
//    }
    
    public static func Bill__LoadDichVu() -> Response<[BillLoadDichVu]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        let returnedData = Response<[BillLoadDichVu]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadHinhThucVanChuyenPOSResult", target: .Bill__LoadDichVu(params: parameters), mappingObj: BillLoadDichVu.self) { (data, err) in
            let checkingResult = data as? [BillLoadDichVu];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //    case Bill__LoadHinhThucThanhToan(params: [String: String])
    public static func Bill__LoadHinhThucThanhToan() -> Response<[BillLoadHinhThucThanhToan]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        let returnedData = Response<[BillLoadHinhThucThanhToan]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadHinhThucThanhToanResult", target: .Bill__LoadHinhThucThanhToan(params: parameters), mappingObj: BillLoadHinhThucThanhToan.self) { (data, err) in
            let checkingResult = data as? [BillLoadHinhThucThanhToan];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //    Bill__LoadDiaChiNhanGanDay
    //    public static func Bill__LoadDiaChiNhanGanDay() -> Response<[BillLoadDiaChiNhan]>{
    //
    //        let parameters: [String: String] = [
    //            "p__UserCode": "\(Cache.user?.UserName ?? "")",
    //            "p__Token": "\(Cache.user?.Token ?? "")",
    //            "p_UserCode": "\(Cache.user?.UserName ?? "")"
    //        ]
    //        let returnedData = Response<[BillLoadDiaChiNhan]>();
    //        let dispatchGroup = DispatchGroup();
    //        dispatchGroup.enter();
    //
    //        self.SendRequest(keyPath: "sp__mCallLog__Bill__LoadDiaChiNhanGanDayResult", target: .Bill__LoadDiaChiNhanGanDay(params: parameters), mappingObj: BillLoadDiaChiNhan.self) { (data, err) in
    //            let checkingResult = data as? [BillLoadDiaChiNhan];
    //            returnedData.Data = checkingResult;
    //            returnedData.Error = err;
    //            dispatchGroup.leave();
    //        }
    //
    //        dispatchGroup.wait();
    //
    //        return returnedData;
    //    }
    
    class func Bill__LoadDiaChiNhanGanDay(handler: @escaping (_ success:[BillLoadDiaChiNhan],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "p_UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        
        var rs:[BillLoadDiaChiNhan] = []
        provider.request(.Bill__LoadDiaChiNhanGanDay(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                if let data = json["sp__mCallLog__Bill__LoadDiaChiNhanGanDayResult"].array {
                    rs = BillLoadDiaChiNhan.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    //    Bill__CreateBill
    public static func Bill__CreateBill(p_Title: String,
                                        p_Cc: String,
                                        p_Sender: String,
                                        p_MaShopPhongBanGui: String,
                                        p_MaShopPhongBanGuiKerry: String,
                                        p_DiaChiGui: String,
                                        p_MaTinhThanhGui: String,
                                        p_TenTinhThanhGui: String,
                                        p_MaQuanHuyenGui: String,
                                        p_TenQuanHuyenGui: String,
                                        p_SoDienThoaiNguoiGui: String,
                                        p_MaShopPhongBanNhan: String,
                                        p_TenShopPhongBanNhan: String,
                                        p_MaShopPhongBanNhanKerry: String,
                                        p_DiaChiNhan: String,
                                        p_MaTinhThanhNhan: String,
                                        p_TenTinhThanhNhan: String,
                                        p_MaQuanHuyenNhan: String,
                                        p_TenQuanHuyenNhan: String,
                                        p_HoTenNguoiNhan: String,
                                        p_SoDienThoaiNguoiNhan: String,
                                        p_MaLoaiHangHoa: String,
                                        p_NoiDungHangHoa: String,
                                        p_SoLuong: String,
                                        p_SoKien: String,
                                        p_TrongLuong: String,
                                        p_MaNhaVanChuyen: String,
                                        TenDichVuVanChuyen: String,
                                        p_MaHinhThucThanhToan: String,
                                        p_GhiChu: String,
                                        p_CuocPhiMin: String,
                                        Is_NVCToiUu: String) -> Response<[BillCreateBill]>{
        
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_Title":p_Title,
            "p_Cc":p_Cc,
            "p_Sender":p_Sender,
            "p_MaShopPhongBanGui":p_MaShopPhongBanGui,
            "p_MaShopPhongBanGuiKerry":p_MaShopPhongBanGuiKerry,
            "p_DiaChiGui":p_DiaChiGui,
            "p_MaTinhThanhGui":p_MaTinhThanhGui,
            "p_TenTinhThanhGui":p_TenTinhThanhGui,
            "p_MaQuanHuyenGui":p_MaQuanHuyenGui,
            "p_TenQuanHuyenGui":p_TenQuanHuyenGui,
            "p_SoDienThoaiNguoiGui":p_SoDienThoaiNguoiGui,
            "p_MaShopPhongBanNhan":p_MaShopPhongBanNhan,
            "p_TenShopPhongBanNhan":p_TenShopPhongBanNhan,
            "p_MaShopPhongBanNhanKerry":p_MaShopPhongBanNhanKerry,
            "p_DiaChiNhan":p_DiaChiNhan,
            "p_MaTinhThanhNhan":p_MaTinhThanhNhan,
            "p_TenTinhThanhNhan":p_TenTinhThanhNhan,
            "p_MaQuanHuyenNhan":p_MaQuanHuyenNhan,
            "p_TenQuanHuyenNhan":p_TenQuanHuyenNhan,
            "p_HoTenNguoiNhan":p_HoTenNguoiNhan,
            "p_SoDienThoaiNguoiNhan":p_SoDienThoaiNguoiNhan,
            "p_MaLoaiHangHoa":p_MaLoaiHangHoa,
            "p_NoiDungHangHoa":p_NoiDungHangHoa,
            "p_SoLuong":p_SoLuong,
            "p_SoKien":p_SoKien,
            "p_TrongLuong":p_TrongLuong,
            "p_MaNhaVanChuyen":p_MaNhaVanChuyen,
            "TenDichVuVanChuyen":TenDichVuVanChuyen,
            "p_MaHinhThucThanhToan":p_MaHinhThucThanhToan,
            "p_GhiChu":p_GhiChu,
            "p_CuocPhiMin":p_CuocPhiMin,
            "Is_NVCToiUu":Is_NVCToiUu
        ]
        let returnedData = Response<[BillCreateBill]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "mCallLog__Bill__CreateBillResult", target: .Bill__CreateBill(params: parameters), mappingObj: BillCreateBill.self) { (data, err) in
            let checkingResult = data as? [BillCreateBill];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    
    class func Bill__LoadDiaChiGui(handler: @escaping (_ success:[BillLoadDiaChiGui],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "p_UserCode": "\(Cache.user?.UserName ?? "")"
        ]
        
        var rs:[BillLoadDiaChiGui] = []
        provider.request(.Bill__LoadDiaChiGui(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let data = json["sp__mCallLog__Bill__LoadDiaChiGuiResult"].array {
                    rs = BillLoadDiaChiGui.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    
    //Cl xuat demo
    //    case let .DemoReq__GetHeader_ByReqId(param):
    //    return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
    //    case let .DemoReq__GetDetail_ByReqId(param):
    //    return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
    //    case let .DemoReq__GetConv_ByReqId(param):
    //    return .requestParameters(parameters: param, encoding:  JSONEncoding.default)
    //    case let .DemoReq__XuLy(params):
    //    return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    
    public static func DemoReq__GetHeader_ByReqId(p_RequestId: String) -> Response<[HeaderXuatDemo]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[HeaderXuatDemo]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DemoReq__GetHeader_ByReqIdResult", target: .DemoReq__GetHeader_ByReqId(params: parameters), mappingObj: HeaderXuatDemo.self) { (data, err) in
            let checkingResult = data as? [HeaderXuatDemo];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func DemoReq__GetDetail_ByReqId(p_RequestId: String) -> Response<[DetailXuatDemo]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[DetailXuatDemo]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DemoReq__GetDetail_ByReqIdResult", target: .DemoReq__GetDetail_ByReqId(params: parameters), mappingObj: DetailXuatDemo.self) { (data, err) in
            let checkingResult = data as? [DetailXuatDemo];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func DemoReq__GetConv_ByReqId(p_RequestId: String) -> Response<[ConversationXuatDemo]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[ConversationXuatDemo]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DemoReq__GetConv_ByReqIdResult", target: .DemoReq__GetConv_ByReqId(params: parameters), mappingObj: ConversationXuatDemo.self) { (data, err) in
            let checkingResult = data as? [ConversationXuatDemo];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    //    "p__UserCode":"6087",
    //    "p__Token":"918752BEC1064F0BB88C938C6513AF05",
    //    "p_RequestId":"5333195",
    //    "p_User":"6087",
    //    "p_NoiDungTraoDoi":"Con cò bé bé",
    //    "p_Images":"6423789|/Uploads/FileAttachs/1421420190514145654c1.jpg;6423790|/Uploads/FileAttachs/1421420190514145700c6.jpg"
    //    "p_FromDevice":"iOS"
    public static func DemoReq__XuLy(p_RequestId: String, p_NoiDungTraoDoi: String, p_Images: String) -> Response<[XuLyXuatDemo]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)",
            "p_User":"\(Cache.user?.UserName ?? "")",
            "p_NoiDungTraoDoi":"\(p_NoiDungTraoDoi)",
            "p_Images":"\(p_Images)",
            "p_FromDevice":"iOS"
        ]
        let returnedData = Response<[XuLyXuatDemo]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DemoReq__XuLyResult", target: .DemoReq__XuLy(params: parameters), mappingObj: XuLyXuatDemo.self) { (data, err) in
            let checkingResult = data as? [XuLyXuatDemo];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //CL DuyetLoiDOA
//    case DuyetLoiDOA_213_LoadConv(params: [String: String])
//    case DuyetLoiDOA_213_LoadDetail(params: [String: String])
//    case DuyetLoiDOA_213_SaveImgUrl(params: [String: String])
    
    public static func DuyetLoiDOA_213_LoadConv(p_RequestId: String) -> Response<[DOA_LoadConvResult]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[DOA_LoadConvResult]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_mCallLog_DuyetLoiDOA_213_LoadConvResult", target: .DuyetLoiDOA_213_LoadConv(params: parameters), mappingObj: DOA_LoadConvResult.self) { (data, err) in
            let checkingResult = data as? [DOA_LoadConvResult];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func DuyetLoiDOA_213_LoadDetail(p_RequestId: String) -> Response<[DOA_LoadDetailResult]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[DOA_LoadDetailResult]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_mCallLog_DuyetLoiDOA_213_LoadDetailResult", target: .DuyetLoiDOA_213_LoadDetail(params: parameters), mappingObj: DOA_LoadDetailResult.self) { (data, err) in
            let checkingResult = data as? [DOA_LoadDetailResult];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func DuyetLoiDOA_213_SaveImgUrl(p_RequestId: String, p_Sender: String, p_LinkImage1: String, p_LinkImage2: String, p_Message: String) -> Response<[DOA_SaveImgUrlResult]>{
        let parameters: [String: String] = [
            "p__UserCode":"\(Cache.user?.UserName ?? "")",
            "p__Token":"\(Cache.user?.Token ?? "")",
            "p_RequestId":"\(p_RequestId)",
            "p_Sender":"\(p_Sender)",
            "p_LinkImage1":"\(p_LinkImage1)",
            "p_LinkImage2":"\(p_LinkImage2)",
            "p_Message":"\(p_Message)",
            "p_Device":"2"
        ]
        let returnedData = Response<[DOA_SaveImgUrlResult]>();
        let dispatchGroup = DispatchGroup();
        
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp_mCallLog_DuyetLoiDOA_213_SaveImgUrlResult", target: .DuyetLoiDOA_213_SaveImgUrl(params: parameters), mappingObj: DOA_SaveImgUrlResult.self) { (data, err) in
            let checkingResult = data as? [DOA_SaveImgUrlResult];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }

//    Bill__KiemTraThongTinUser

    public static func Bill__KiemTraThongTinUser() -> Response<[BillKiemTraThongTinUser]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")"
        ]
        let returnedData = Response<[BillKiemTraThongTinUser]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__Bill__KiemTraThongTinUserResult", target: .Bill__KiemTraThongTinUser(params: parameters), mappingObj: BillKiemTraThongTinUser.self) { (data, err) in
            let checkingResult = data as? [BillKiemTraThongTinUser];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
//    Bill__CancelBill
    public static func Bill__CancelBill(RequestId: String) -> Response<[CancelBill]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "RequestId":"\(RequestId)"
        ]
        let returnedData = Response<[CancelBill]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "mCallLog__Bill__CancelBillResult", target: .Bill__CancelBill(params: parameters), mappingObj: CancelBill.self) { (data, err) in
            let checkingResult = data as? [CancelBill];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //  Duyet cong no VNPT
    public static func DuyetCongNoVNPTReq__GetDetail_ByReqId(p_RequestId: String) -> Response<[DuyetCongNoVNPT]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "p_RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[DuyetCongNoVNPT]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DuyetCongNoVNPTReq__GetDetail_ByReqIdResult", target: .DuyetCongNoVNPTReq__GetDetail_ByReqId(params: parameters), mappingObj: DuyetCongNoVNPT.self) { (data, err) in
            let checkingResult = data as? [DuyetCongNoVNPT];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    public static func DuyetCongNoVNPTReq__XuLy(p_RequestId: String, p_Duyet: String, p_LyDo: String) -> Response<[XuLyDuyetCongNoVNPT]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "p_RequestId":"\(p_RequestId)",
            "p_Duyet":"\(p_Duyet)",
            "p_LyDo":"\(p_LyDo)",
            "p_User":"\(Cache.user!.UserName)"
        ]
        let returnedData = Response<[XuLyDuyetCongNoVNPT]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "sp__mCallLog__DuyetCongNoVNPTReq__XuLyResult", target: .DuyetCongNoVNPTReq__XuLy(params: parameters), mappingObj: XuLyDuyetCongNoVNPT.self) { (data, err) in
            let checkingResult = data as? [XuLyDuyetCongNoVNPT];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        
        dispatchGroup.wait();
        
        return returnedData;
    }
    
    //Duyet han muc the cao
    public static func DuyetHanMucTheCao_TypeId_226_GetDetail(p_RequestId: String) -> Response<[TypeId_226_GetDetail]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[TypeId_226_GetDetail]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "TypeId_226_GetDetailResult", target: .DuyetHanMucTheCao_TypeId_226_GetDetail(params: parameters), mappingObj: TypeId_226_GetDetail.self) { (data, err) in
            let checkingResult = data as? [TypeId_226_GetDetail];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func DuyetHanMucTheCao_TypeId_226_GetConv(p_RequestId: String) -> Response<[TypeId_226_GetConv]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "RequestId":"\(p_RequestId)"
        ]
        let returnedData = Response<[TypeId_226_GetConv]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "TypeId_226_GetConvResult", target: .DuyetHanMucTheCao_TypeId_226_GetConv(params: parameters), mappingObj: TypeId_226_GetConv.self) { (data, err) in
            let checkingResult = data as? [TypeId_226_GetConv];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        dispatchGroup.wait();
        return returnedData;
    }
    
    public static func DuyetHanMucTheCao_TypeId_226_PushConv(p_RequestId: String, Message: String) -> Response<[XuLyDuyetCongNoVNPT]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "RequestId":"\(p_RequestId)",
            "UserCode":"\(Cache.user!.UserName)",
            "Message":"\(Message)"
        ]
        let returnedData = Response<[XuLyDuyetCongNoVNPT]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "TypeId_226_PushConvResult", target: .DuyetHanMucTheCao_TypeId_226_PushConv(params: parameters), mappingObj: XuLyDuyetCongNoVNPT.self) { (data, err) in
            let checkingResult = data as? [XuLyDuyetCongNoVNPT];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        dispatchGroup.wait();
        return returnedData;
    }
    public static func DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(p_RequestId: String, NewLimit: String, StatusConfirm: String) -> Response<[TypeId_226_DuyetHanMuc]>{
        
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user!.UserName)",
            "p__Token": "\(Cache.user!.Token)",
            "RequestId":"\(p_RequestId)",
            "InsideCode":"\(Cache.user!.UserName)",
            "NewLimit":"\(NewLimit)",
            "StatusConfirm":"\(StatusConfirm)",
        ]
        let returnedData = Response<[TypeId_226_DuyetHanMuc]>();
        let dispatchGroup = DispatchGroup();
        dispatchGroup.enter();
        
        self.SendRequest(keyPath: "TypeId_226_DuyetHanMucResult", target: .DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(params: parameters), mappingObj: TypeId_226_DuyetHanMuc.self) { (data, err) in
            let checkingResult = data as? [TypeId_226_DuyetHanMuc];
            returnedData.Data = checkingResult;
            returnedData.Error = err;
            dispatchGroup.leave();
        }
        dispatchGroup.wait();
        return returnedData;
    }
//    FEC
    class func TypeId_227_GetDetail(RequestId: String, handler: @escaping (_ success:DetailFEC_227?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "RequestId": "\(RequestId)"
        ]
        provider.request(.TypeId_227_GetDetail(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                
                let mData = json["TypeId_227_GetDetailResult"]
                let rs = DetailFEC_227.getObjFromDictionary(data: mData)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    //posm
    class func mCallLog_DanhSachCongViec_GetRequest(handler: @escaping (_ success:[WorkPosm]?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
        ]
        provider.request(.mCallLog_DanhSachCongViec_GetRequest(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                let rs = WorkPosm.parseObjfromArray(array: json?.array ?? [])
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"")
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func TypeId_229_GetDetail(RequestId: String, handler: @escaping (_ success:[DetailCallLogPosm],_ title:String, _ reason:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "RequestId": "\(RequestId)"
        ]
        provider.request(.TypeId_229_GetDetail(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                
                let title = json?["RequestTitle"].string
                let reason = json?["LyDoKhongUpHinh"].string
                if let data = json?["Details"].array {
                    
                    let rs = DetailCallLogPosm.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,title ?? "",reason ?? "","")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([],title ?? "",reason ?? "","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([],"","",error.localizedDescription)
            }
        }
    }
    class func TypeId_229_UploadImage(RequestId:String,RequestDetailId:String,Base64: String, handler: @escaping (_ success:ResultUploadImagePosm?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "RequestId": "\(RequestId)",
            "RequestDetailId":"\(RequestDetailId)",
            "Base64":"\(Base64)"
        ]
        provider.request(.TypeId_229_UploadImage(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                
                if json != nil {
                    let rs = ResultUploadImagePosm.getObjFromDictionary(data: json!)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if rs.Url == "" {
                        handler(nil,"Up ảnh lỗi, cần upload lại ảnh")
                    } else {
                        handler(rs,"")
                    }
                }else{
                  
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"LOAD API ERROR !")
                }
              
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func TypeId_229_XuLy(RequestId:String,Details:Any, handler: @escaping (_ Result:TypeId_229_XuLyResult?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "p__UserCode": "\(Cache.user?.UserName ?? "")",
            "p__Token": "\(Cache.user?.Token ?? "")",
            "RequestId":"\(RequestId)",
            "Details": Details
        ]
        print(parameters)
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 60
        provider.request(.TypeId_229_XuLy(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if json != nil {
                    let rs = TypeId_229_XuLyResult.getObjFromDictionary(data: json!)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"LOAD API ERROR !")
                }
                
                
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func Calllog_FRTUService_AttachFile_Upload(email: String, fileName: String, extension_file: String, stringBase64: String, handler: @escaping (_ success:FRTUService_AttachFile_Upload?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "email": "\(email)",
            "token": "\(Cache.user!.Token)",
            "fileName": "\(fileName)",
            "extension_file": "\(extension_file)",
            "content": "\(stringBase64)"
        ]
        provider.request(.Calllog_FRTUService_AttachFile_Upload(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let rs = FRTUService_AttachFile_Upload.getObjFromDictionary(data: json)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func Calllog_FRTUService_Ticket_Create(email: String, title: String, list_upload: String, content: String, note: String, sender: String, informedUsers: String, handler: @escaping (_ success:FRTUService_Ticket_Create?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<mCallLogApiService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "email": "\(email)",
            "token": "\(Cache.user!.Token)",
            "title": "\(title)",
            "list_upload": "\(list_upload)",
            "content": "\(content)",
            "note": "\(note)",
            "sender": "\(sender)",
            "group_function_name": "Dịch vụ",
            "function_name": "Kích hoạt sim",
            "informedUsers": "\(informedUsers)",
            "processId": "192"
        ]
        debugPrint(parameters)
        provider.request(.Calllog_FRTUService_Ticket_Create(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                let rs = FRTUService_Ticket_Create.getObjFromDictionary(data: json)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,"")
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
}
