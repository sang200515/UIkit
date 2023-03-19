//
//  MDeliveryAPIManager.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/22/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire
public class MDeliveryAPIManager{
//    class func getSOByUser2(UserID:String,ToKen:String,SysType: String,TypeAPP:String,handler: @escaping (_ success:[SOByUser2],_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        var rs:[SOByUser2] = []
//        let param: [String:String] = [
//            "UserID":UserID,
//            "ToKen":ToKen,
//            "SysType":SysType,
//            "TypeAPP":TypeAPP
//        ]
//        provider.request(.getSOByUser2(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                if let success = json["success"].bool {
//                    if(success){
//                        if let list = json["data"].array {
//                            rs = SOByUser2.parseObjfromArray(array: list)
//                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                            handler(rs,"")
//                        }else{
//                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                            handler(rs,"Load API ERRO")
//                        }
//                    }else{
//
//                    }
//                }else{
//
//                }
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,error.localizedDescription)
//            }
//        }
//    }
//
//    class func GiaoNhan_CallUpHinhChuKi(Docentry: String,DiviceType:String,CustomerSignature:String,Deliverer:String,Stockkeeper:String ,Accountant:String,handler: @escaping (_ success:GenImage_Confirm_DeliverResult?,_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        let param: [String:String] = [
//            "Docentry" : Docentry ,"DiviceType": DiviceType , "CustomerSignature" : CustomerSignature, "Deliverer" : Deliverer, "Stockkeeper" : Stockkeeper , "Accountant" : Accountant
//        ]
//        provider.request(.GiaoNhan_CallUpHinhChuKi(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                let rs = GenImage_Confirm_DeliverResult.getObjFromDictionary(data: json)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,"")
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(nil,error.localizedDescription)
//            }
//        }
//    }
//    class func GetDataSetSOInfo(docNum :String, userName :String, empName :String , bookDate :String, whConfirmed :String, whDate :String, rejectReason :String, rejectDate :String, paymentType :String, paymentAmount :String, paymentDistance :String , finishLatitude :String, finishLongitude :String, finishTime :String, paidConfirmed :String, paidDate :String, orderStatus :String, u_addDel :String, u_dateDe :String, u_paidMoney :String, rowVersion :String,Is_PushSMS:String,U_AdrDel_New_Reason:String, U_DateDe_New_Reason:String,handler: @escaping (_ success:ConfirmThuKhoResult?,_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        let param: [String:String] = [
//            "docNum" : docNum ,"userName": userName , "empName" : empName, "bookDate" : bookDate, "whConfirmed" : whConfirmed , "whDate" : whDate,"rejectReason" : rejectReason ,"rejectDate": rejectDate , "paymentType" : paymentType, "paymentAmount" : paymentAmount, "paymentDistance" : paymentDistance , "finishLatitude" : finishLatitude, "finishLongitude" : finishLongitude ,"finishTime": finishTime , "paidConfirmed" : paidConfirmed, "paidDate" : paidDate, "orderStatus" : orderStatus , "u_addDel" : u_addDel,"u_dateDe" : u_dateDe ,"u_paidMoney": u_paidMoney , "rowVersion" : rowVersion, "Is_PushSMS" : Is_PushSMS, "U_AdrDel_New_Reason" : U_AdrDel_New_Reason , "U_DateDe_New_Reason" : U_DateDe_New_Reason
//        ]
//        provider.request(.GetDataSetSOInfo(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                let rs = ConfirmThuKhoResult.getObjFromDictionary(data: json)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,"")
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(nil,error.localizedDescription)
//            }
//        }
//    }
//    class func GetUnConfirmThuKho(docNum: String, userCode:String, password:String,cantCallReason:String,handler: @escaping (_ success:ConfirmThuKhoResult?,_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        let param: [String:String] = [
//            "docNum" : docNum ,"userCode": userCode , "password" : password, "cantCallReason" : cantCallReason
//        ]
//        provider.request(.GetUnConfirmThuKho(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                let rs = ConfirmThuKhoResult.getObjFromDictionary(data: json)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,"")
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(nil,error.localizedDescription)
//            }
//        }
//    }
//    class func GetDataSetSOReturned(docNum: String, userCode:String, reason:String,is_Returned:String,handler: @escaping (_ success:ConfirmThuKhoResult?,_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        let param: [String:String] = [
//            "docNum" : docNum ,"userCode": userCode , "is_Returned" : is_Returned, "reason" : reason
//        ]
//        provider.request(.GetDataSetSOReturned(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                let rs = ConfirmThuKhoResult.getObjFromDictionary(data: json)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,"")
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(nil,error.localizedDescription)
//            }
//        }
//    }
//    //CHUA XONG
//    class func GetReportDeliveryHeader(p_MaNV: String, p_TinhTrangSO:String, p_SoDHPOS:String,handler: @escaping (_ success:ConfirmThuKhoResult?,_ error:String) ->Void){
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        let provider = MoyaProvider<MDeliveryAPIService2>(plugins: [NetworkLoggerPlugin()])
//        let param: [String:String] = [
//            "p_MaNV" : p_MaNV ,"p_TinhTrangSO": p_TinhTrangSO , "p_SoDHPOS" : p_SoDHPOS
//        ]
//        provider.request(.GetReportDeliveryHeader(param:param)){ result in
//            switch result {
//            case let .success(moyaResponse):
//                let data = moyaResponse.data
//                let json = try! JSON(data: data)
//                debugPrint(json)
//                let rs = ConfirmThuKhoResult.getObjFromDictionary(data: json)
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(rs,"")
//            case let .failure(error):
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                handler(nil,error.localizedDescription)
//            }
//        }
//    }
    
}
