//
//  APIManager.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/25/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str))")
        }
        #endif
        return request
    }
}

public class APIManager{
    class func login(UserName:String,Password:String,CRMCode:String,SysType:String,handler: @escaping (_ success:User?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let log = SwiftyBeaver.self
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        provider.request(.login(UserName:UserName,Password:Password,CRMCode:CRMCode,SysType:SysType)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                log.debug(json)
                //debugPrint(json)
                if let jsonUser = json["mpos_sp_inov_Authenticate"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            let rs = User.getObjFromDictionary(data: data)
                            if(rs.p_status == 1){
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rs,"")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(nil,rs.p_messages)
                            }
                        }else{
                            handler(nil,"Đăng nhập không thành công! (3)")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Đăng nhập không thành công! (2)")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Đăng nhập không thành công! (1)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func checkVersion(handler: @escaping (_ success:[VersionApp],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[VersionApp] = []
        let log = SwiftyBeaver.self
        provider.request(.checkVersion){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                log.debug(json as Any)
                if let success = json?["Success"].bool {
                    if (success){
                        if let data = json!["Data"].array {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            rs = VersionApp.parseObjfromArray(array: data)
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"LOAD API ERR")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"LOAD API ERR")
                    }
                }else{
                    if let message = json?["message"].string{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,message)
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"LOAD API ERR")
                    }
                    
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
        
    }
    
    class func registerDeviceToken(){
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["deviceId" : "\(Cache.UUID)","deviceToken" : "\(Cache.TOKEN)","deviceOS":"2","userCode":"\(Cache.user!.UserName)","shopCode": "\(Cache.user!.ShopCode)"]
        provider.request(.registerDeviceToken(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    class func removeDeviceToken(){
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = ["deviceId" : "\(Cache.UUID)"]
        provider.request(.removeDeviceToken(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    class func sp_mpos_FRT_SP_GetNotify_oneapp(handler: @escaping (_ success:[NotificationObject],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaCodeCrm": "\(crm ?? "")",
            "TokenApi":"\(Cache.user!.Token)"
        ]
        var list: [NotificationObject] = []
        provider.request(.sp_mpos_FRT_SP_GetNotify_oneapp(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            list = NotificationObject.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_delete_notify(IDNotify: String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let crm =  UserDefaults.standard.string(forKey: "CRMCode")
        let parameters = [
            "UserID" : "\(Cache.user!.UserName)",
            "MaCodeCrm": "\(crm ?? "")",
            "TokenApi":"\(Cache.user!.Token)",
            "IDNotify":"\(IDNotify)"
        ]
        provider.request(.sp_mpos_FRT_SP_delete_notify(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json?["Data"].array {
                            if(data.count > 0){
                                let p_status = data[0]["p_status"].intValue
                                let p_messagess = data[0]["p_messagess"].stringValue
                                handler(p_status,p_messagess)
                            }else{
                                handler(0,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }
    class func sp_mpos_FRT_SP_notify_update(IDNotify: String,type:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "ID":"\(IDNotify)",
            "type":"\(type)"
        ]
        provider.request(.sp_mpos_FRT_SP_notify_update(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let data = json["Data"].array {
                            if(data.count > 0){
                                let p_status = data[0]["p_status"].intValue
                                let p_messagess = data[0]["p_messagess"].stringValue
                                handler(p_status,p_messagess)
                            }else{
                                handler(0,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }
    class func checkUserCheckInV2(userCode:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "userCode":"\(userCode)"
        ]
        provider.request(.checkUserCheckInV2(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let jsonUser = json["checkUserCheckInV2Result"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            var KQ = data["KQ"].bool
                            KQ = KQ == nil ? false : KQ
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(KQ!,"")
                        }else{
                            handler(false,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    class func checkUserCheckOut(userCode:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "userCode":"\(userCode)"
        ]
        provider.request(.checkUserCheckOut(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let jsonUser = json["checkUserCheckOutResult"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            var KQ = data["KQ"].bool
                            KQ = KQ == nil ? false : KQ
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(KQ!,"")
                        }else{
                            handler(false,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    class func getListShiftDate(userCode:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "userCode":"\(userCode)"
        ]
        provider.request(.getListShiftDate(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let jsonUser = json["getListShiftDateResult"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            var KQ = data["KQ"].bool
                            KQ = KQ == nil ? false : KQ
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(KQ!,"")
                        }else{
                            handler(false,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    class func insertCheckIn(userCode:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "userCode":"\(userCode)"
        ]
        provider.request(.insertCheckIn(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let jsonUser = json["checkUserCheckOutResult"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            var KQ = data["KQ"].bool
                            KQ = KQ == nil ? false : KQ
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(KQ!,"")
                        }else{
                            handler(false,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    class func insertCheckOut(userCode:String,handler: @escaping (_ success:Bool,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "userCode":"\(userCode)"
        ]
        provider.request(.insertCheckOut(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let jsonUser = json["checkUserCheckOutResult"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            var KQ = data["KQ"].bool
                            KQ = KQ == nil ? false : KQ
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(KQ!,"")
                        }else{
                            handler(false,"")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(false,"")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(false,"")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(false,error.localizedDescription)
            }
        }
    }
    
    class func sp_mpos_FRT_SP_oneapp_CheckMenu(UserName:String,handler: @escaping (_ success:[RuleMenu],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : "\(UserName)",
            "MenuName": "0"
        ]
        var list: [RuleMenu] = []
        provider.request(.sp_mpos_FRT_SP_oneapp_CheckMenu(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            list = RuleMenu.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(list,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(list,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func searchContacts(keyWords:String,handler: @escaping (_ success:[ItemContact],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "keyWords" : "\(keyWords)"
        ]
        var list: [ItemContact] = []
        provider.request(.searchContacts(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)

                if let data = json?["searchContactsResult"].array {
                    list = ItemContact.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(list,error.localizedDescription)
            }
        }
    }
    class func checkOTP(username:String,handler: @escaping (_ success:OTP?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "username" : "\(username)"
        ]
        provider.request(.checkOTP(param: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                let data = moyaResponse.data
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(statusCode == 200){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    let rs = OTP.getObjFromDictionary(data: json)
                    handler(rs,"")
                }else if(statusCode == 404){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    if let _ = json["error"].int {
                        if let message = json["message"].string {
                            handler(nil,message)
                        }else{
                            handler(nil,"LOAD API ERR")
                        }
                    }else{
                        handler(nil,"LOAD API ERR")
                    }
                }else if(statusCode == 400){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    if let _ = json["error"].int {
                        if let message = json["message"].string {
                            handler(nil,message)
                        }else{
                            handler(nil,"LOAD API ERR")
                        }
                    }else{
                        handler(nil,"LOAD API ERR")
                    }
                }else{
                    handler(nil,"LOAD API ERR")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func mpos_sp_GateWay_GetInfoLogin(UserName:String,handler: @escaping (_ success:User?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [VerbosePlugin(verbose: true)])
        let parameters = [
            "UserName" : "\(UserName)",
            "SysType": "0"
        ]
        provider.request(.mpos_sp_GateWay_GetInfoLogin(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if let jsonUser = json?["mpos_sp_inov_Authenticate"].array {
                    if (jsonUser.count > 0){
                        let data = jsonUser[0]
                        if(!data.isEmpty){
                            let rs = User.getObjFromDictionary(data: data)
                            if(rs.p_status == 1){
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(rs,"")
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(nil,rs.p_messages)
                            }
                        }else{
                            handler(nil,"Đăng nhập không thành công! (3)")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Đăng nhập không thành công! (2)")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,"Đăng nhập không thành công! (1)")
                }    case let .failure(error):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,error.localizedDescription)
            }
        }
    }
    
    class func getOTP(username:String,action:String,handler: @escaping (_ success:OTP?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "username" : "\(username)",
            "action" : "\(action)"
        ]
        provider.request(.getOTP(param: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                let data = moyaResponse.data
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if(statusCode == 200){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    let rs = OTP.getObjFromDictionary(data: json)
                    handler(rs,"")
                }else if(statusCode == 404){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    if let _ = json["error"].int {
                        if let message = json["message"].string {
                            handler(nil,message)
                        }else{
                            handler(nil,"LOAD API ERR")
                        }
                    }else{
                        handler(nil,"LOAD API ERR")
                    }
                }else if(statusCode == 400){
                    let json = try! JSON(data: data)
                    debugPrint(json)
                    if let _ = json["error"].int {
                        if let message = json["message"].string {
                            handler(nil,message)
                        }else{
                            handler(nil,"LOAD API ERR")
                        }
                    }else{
                        handler(nil,"LOAD API ERR")
                    }
                }else{
                    handler(nil,"LOAD API ERR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
        
    }
    class func sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(UserID_OTP:String,handler: @escaping (_ success:Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : "\(Cache.user!.UserName)",
            "UserID_OTP": UserID_OTP
        ]
        provider.request(.sp_mpos_FRT_SP_Check_quyen_gen_otp_getway(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json ?? "")
                if let success = json?["Success"].bool {
                    if(success){
                        if let data = json?["Data"].array {
                            if(data.count > 0){
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                var p_status = data[0]["p_status"].int
                                var p_messagess = data[0]["p_messagess"].string
                                p_status = p_status == nil ? 0 : p_status
                                p_messagess = p_messagess == nil ? "" : p_messagess
                                handler(p_status!,p_messagess!)
                            }else{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                handler(0,"Load API ERRO")
                            }
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(0,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0,"Load API ERRO")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0,error.localizedDescription)
            }
        }
    }

    class func require_sso_token(ssoId:String,url:String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "ssoId":ssoId,
            "url":url
        ]
        provider.request(.require_sso_token(param: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if(moyaResponse.statusCode == 200){
                    if let ssoToken = json["ssoToken"].string {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let urlFN = "ssoToken=\(ssoToken)&ssoId=\(ssoId)"
                        handler(urlFN,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","LOAD API ERR")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if let message = json["message"].string {
                        handler("",message)
                    }else{
                        handler("","LOAD API ERR")
                    }
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    //viettelpay
    class func mpos_FRT_SP_authen_get_list_shop_by_user(UserID:String,handler: @escaping (_ success:[ShopLogin],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "UserID" : "\(UserID)"
        ]
        var rs:[ShopLogin] = []
        provider.request(.mpos_FRT_SP_authen_get_list_shop_by_user(param:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                debugPrint(json)
                if let success = json["Success"].bool {
                    if(success){
                        if let data = json["Data"].array {
                            rs = ShopLogin.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
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
    
    class func mpos_FRT_Call_Customer_GetData(type:String, handler: @escaping (_ success:[CallCSKH],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[CallCSKH] = []
        let parameters: [String: String] = [
            "ShopCode":"\(Cache.user!.ShopCode)",
            "UserCode":"\(Cache.user!.UserName)",
            "Type":"\(type)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_Call_Customer_GetData(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue

                if(success){
                    if let data = json["Data"].array {
                        rs = CallCSKH.parseObjfromArray(array: data)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Call_Customer_UpdateInfo(ID:String, Phone:String, handler: @escaping (_ rsCode:Int, _ msg:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ShopCode":"\(Cache.user!.ShopCode)",
            "UserCode":"\(Cache.user!.UserName)",
            "ID":"\(ID)",
            "Phone":"\(Phone)"
        ]
        print(parameters)
        provider.request(.mpos_FRT_Call_Customer_UpdateInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try! JSON(data: data)
                print(json)
                let success = json["Success"].boolValue
                if(success){
                    let mdata = json["Data"]
                    let rsCode = mdata["Result"].intValue
                    let msg = mdata["Message"].string
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rsCode,msg ?? "", "")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "","Load API ERRO")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func getTokenAD( username:String,password:String,otp:String,completion: @escaping(_ result: String, _ message: String)->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "\(APIService.tokenAD.baseURL)\(APIService.tokenAD.path)"
        let parameters: [String: Any] = [
            "client_id":"mobile-client",
            "scope":"openid profile som",
            "username":"\(username)",
            "password":"\(password)",
            "grant_type":"password_otp",
            "otp":"\(otp)"
            //                "response_type":"token"
        ]
        print(parameters)
        print(url)

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                let memberData = "\(value)".data(using: String.Encoding.utf8) ?? Data()
                multipartFormData.append(memberData, withName: "\(key)")
            }
        }, to: url).uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { response in
            print(response.data as Any)

            if let data = response.data, let json = try? JSON(data: data) {
                if let access_token = json["access_token"].string {
                    print(access_token)
                    let defaults = UserDefaults.standard
                    defaults.set(access_token , forKey: "access_token")
                    UserDefaults.standard.setMyInfoToken(token: access_token)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion("Success","")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if let error_description = json["error_description"].string {
                        completion("",error_description)
                    } else {
                        if let error = json["message"].string {
                            completion("",error)
                        } else {
                            completion("","LOAD API ERROR")
                        }
                    }
                }
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion("","LOAD API ERROR")
            }
        })
    }
    
    class func userinfo(handler: @escaping (_ result:UserInfoAD?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.userInfoAD){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)

                if(json != nil){
                    let rs = UserInfoAD.getObjFromDictionary(data: json!)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    handler(nil,"Đăng nhập không thành công! (3)")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,error.localizedDescription)
            }
        }
    }
    class func gateway_login(username:String,password:String,otpCode: String,handler: @escaping (_ success:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "username":username,
            "password":password,
            "otpCode":otpCode
        ]
        print(parameters)
        provider.request(.gateway_login(param: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                debugPrint(json as Any)
                if(moyaResponse.statusCode == 200){
                    if let access_token = json?["access_token"].string {
                        let defaults = UserDefaults.standard
                        defaults.set(access_token, forKey: "access_token")
                        UserDefaults.standard.setMyInfoToken(token: access_token)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("Success","")
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","LOAD API ERR")
                    }
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if let message = json?["message"].string {
                        handler("",message)
                    }else{
                        handler("","LOAD API ERR")
                    }
                }

            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func gnnbv2_GetTransport(FormDate:String, ToDate:String, StatusBill: String, handler: @escaping (_ rs: [GNNB_GetTransport], _ roleType: Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "ShopCode_Ex":"\(Cache.user!.ShopCode)",
            "User":"\(Cache.user!.UserName)",
            "FormDate":"\(FormDate)",
            "ToDate":"\(ToDate)",
            "StatusBill":"\(StatusBill)"
        ]
        print(parameters)
        provider.request(.gnnbv2_GetTransport(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let dict = arrJson[0]
                        let roleType = dict["roleType"].intValue
                        let mData = dict["data"].array ?? []
                        let rs = GNNB_GetTransport.parseObjfromArray(array: mData)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, roleType, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], 0, "API ERROR")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], 0, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], 0, error.localizedDescription)
            }
        }
    }
    class func gnnbv2_ScanQRCode(BinCode:String, handler: @escaping (_ rs: GNNB_ScanQRCode?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "binCode":"\(BinCode)",
            "shopCode":"\(Cache.user!.ShopCode)",
            "user":"\(Cache.user!.UserName)"
        ]
        
        provider.request(.gnnbv2_ScanQRCode(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let rs = GNNB_ScanQRCode.getObjFromDictionary(data: arrJson[0])
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil, "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func gnnbv2_ScanQRCodeVerify(keyUserPass:String, arrCode_Bin:[CodeBin], shiperName: String, billType: String, handler: @escaping (_ result: ScanQRCodeVerify?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        var arrParamCodeBin = [[String:String]]()
        for item in arrCode_Bin {
            let dict:[String:String] = ["billCode":"\(item.billCode)", "binCode":"\(item.arrBinCode)"]
            //            let dict2 = NSDictionary(dictionary: ["billCode":"\(item.billCode)", "binCode":"\(item.arrBinCode)"])
            arrParamCodeBin.append(dict)
        }
        
        let parameters: [String: Any] = [
            "user": "\(Cache.user!.UserName)",
            "ShopCode_Ex": "\(Cache.user!.ShopCode)",
            "Code_Bin": arrParamCodeBin,
            "keyUserPass": "\(keyUserPass)",
            "shiperName": "\(shiperName)",
            "billType": "\(billType)"
        ]
        debugPrint(parameters)
        
        provider.request(.gnnbv2_ScanQRCodeVerify(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let rs = ScanQRCodeVerify.getObjFromDictionary(data: arrJson[0])
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil, "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func gnnbv2_GenQRCodeImg(typeQRCode:String, handler: @escaping (_ keyUser: String,_ type: String,_ result:String,_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "user": "\(Cache.user!.UserName)",
            "typeQRCode": "\(typeQRCode)"
        ]
        debugPrint(parameters)
        
        provider.request(.gnnbv2_GenQRCodeImg(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let keyUser = rs["keyUser"].stringValue
                        let type = rs["type"].stringValue
                        let result = rs["result"].stringValue
                        let msg = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(keyUser, type, result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", "", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", "", "", error.localizedDescription)
            }
        }
    }
    class func gnnbv2_UnBookBill(billCode:String, handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "user": "\(Cache.user!.UserName)",
            "billCode": "\(billCode)"
        ]
        debugPrint(parameters)
        
        provider.request(.gnnbv2_UnBookBill(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func gnnbv2_UnBookListBill(arrCode_Bin:[CodeBin], handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        var arrParamCodeBin = [[String:String]]()
        for item in arrCode_Bin {
            let dict:[String:String] = ["billCode":"\(item.billCode)", "binCode":"\(item.arrBinCode)"]
            arrParamCodeBin.append(dict)
        }
        
        let parameters: [String: Any] = [
            "user": "\(Cache.user!.UserName)",
            "code_Bin": arrParamCodeBin
        ]
        debugPrint(parameters)
        
        provider.request(.gnnbv2_UnBookListBill(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    print(json)
                    let arrJson = json.array ?? []
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func checkWhs(itemCode:String, quantity: Int, handler: @escaping (_ results: [ItemWarehouse]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "shopCode": "\(Cache.user!.ShopCode)",
            "itemCode": "\(itemCode)",
            "quantity": quantity,
            "user": "\(Cache.user!.UserName)",
        ]
        debugPrint(parameters)
        
        provider.request(.checkWhs(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    var list:[ItemWarehouse] = []
                    
                    for item in arrJson {
                        let shopCode = item["shopCode"].stringValue
                        let shopName = item["shopName"].stringValue
                        let whsCode = item["whsCode"].stringValue
                        let whsName = item["whsName"].stringValue
                        let distance = item["distance"].stringValue
                        let qty_Available = item["qty_Available"].stringValue
                        
                        let itemCode = item["itemCode"].stringValue
                        let itemName = item["itemName"].stringValue
                        let manSerNum = item["manSerNum"].stringValue
                        list.append(ItemWarehouse(shopCode: shopCode,shopName: shopName,whsCode: whsCode,whsName: whsName,distance: distance,qty_Available:qty_Available,itemCode:itemCode,itemName:itemName,manSerNum:manSerNum))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (_) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                }
                
            case .failure(let error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)
            }
        }
    }
    class func createYCDC(param: RequestYCDC, handler: @escaping (_ results: String,_ msg: String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let paramDic = param.dictionary!
        debugPrint(paramDic)
        
        provider.request(.createYCDC(params:paramDic)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    print(arrJson)
                    var msg = ""
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let soYCDC = rs["soYCDC"].stringValue
                        let _ = rs["series"].stringValue
                        let message = rs["message"].arrayValue
                  
                        if message.count > 0 {
                            msg = message[0]["message"].stringValue
                        }
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(soYCDC,msg)
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Có lỗi xẩy ra!")
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","Có lỗi xẩy ra!")
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("",error.localizedDescription)
            }
        }
    }
    class func searchYCDC(fromDate:String, toDate:String, handler: @escaping (_ results: [BodyYCDC]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "shopCode": "\(Cache.user!.ShopCode)",
            "fromDate": "\(fromDate)",
            "toDate": toDate,
            "user": "\(Cache.user!.UserName)",
        ]
        debugPrint(parameters)
        
        provider.request(.searchYCDC(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    var list:[BodyYCDC] = []
                    
                        let json = try JSON(data: data)
                        
                        let arrJson = json.array ?? []
                        for item in arrJson {
                            let docEntry = item["docEntry"].stringValue
                            let createDate = item["createDate"].stringValue
                            let u_ShpCod = item["u_ShpCod"].stringValue
                            let u_ShpRec = item["u_ShpRec"].stringValue
                            let createBy = item["createBy"].stringValue
                            
                            let updateBy = item["updateBy"].stringValue
                            let statusName = item["statusName"].stringValue
                            let statusCode = item["statusCode"].stringValue
                            
                            let u_WhsEx = item["u_WhsEx"].stringValue
                            let u_WhsRec = item["u_WhsRec"].stringValue
                            let remarks = item["remarks"].stringValue
                            let shpCod = item["shpCod"].stringValue
                            let shpRec = item["shpRec"].stringValue
                            
                            list.append(BodyYCDC(docEntry : docEntry, createDate: createDate, u_ShpCod : u_ShpCod, u_ShpRec : u_ShpRec, createBy: createBy, updateBy : updateBy, statusName : statusName, statusCode: statusCode,u_WhsEx:u_WhsEx,u_WhsRec:u_WhsRec,remarks:remarks,shpRec:shpRec,shpCod:shpCod))
                        }
                        
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func cancelYCDC(soYCDC: String,remark:String, handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
    
        
        let parameters: [String: Any] = [
            "shopCode": "\(Cache.user!.ShopCode)",
            "soYCDC": "\(soYCDC)",
            "remark": remark,
            "user": "\(Cache.user!.UserName)",
            "os":"2"
        ]
        print(parameters)
        
        provider.request(.cancelYCDC(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    print(arrJson)
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func approledYCDC(param: RequestApproledYCDC, handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let paramDic = param.dictionary!
        debugPrint(paramDic)
        
        provider.request(.approledYCDC(params:paramDic)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    print(arrJson)
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func detailYCDC(soYCDC:String, handler: @escaping (_ results: [DetailYCDC]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "shopCode": "\(Cache.user!.ShopCode)",
            "soYCDC": soYCDC,
            "user": "\(Cache.user!.UserName)",
        ]
        debugPrint(parameters)
        
        provider.request(.detailYCDC(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
              
                    let arrJson = json.array ?? []
                 
                    var list:[DetailYCDC] = []
                    
                    for item in arrJson {
                        let docEntry = item["docEntry"].stringValue
                        let u_ShpCod = item["u_ShpCod"].stringValue
                        let u_ShpRec = item["u_ShpRec"].stringValue
                        let u_ItmCod = item["u_ItmCod"].stringValue
                        let u_ItmNam = item["u_ItmNam"].stringValue
                        let lineId = item["lineId"].stringValue
                        let u_WhsEx = item["u_WhsEx"].stringValue
                        let u_WhsRec = item["u_WhsRec"].stringValue
                        let u_Qutity = item["u_Qutity"].stringValue
                        let u_WhsCodeEx = item["u_WhsCodeEx"].stringValue
                        let u_WhsCodeRec = item["u_WhsCodeRec"].stringValue
                        
                        list.append(DetailYCDC(docEntry : docEntry,u_ShpCod: u_ShpCod,u_ShpRec : u_ShpRec, u_ItmCod : u_ItmCod, u_ItmNam: u_ItmNam,lineId : lineId,u_WhsEx : u_WhsEx, u_WhsRec: u_WhsRec, u_Qutity: u_Qutity,quantity_Ap: Int(Double(u_Qutity) ?? 0),u_WhsCodeEx:u_WhsCodeEx,u_WhsCodeRec:u_WhsCodeRec))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)

                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func searchVanDon(fromDate:String, toDate:String,shopCodeEx:String,shopCodeRec:String,statusCode:String,transporter:String,soBillFRT:String, handler: @escaping (_ results: [VanDon]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "fromDate": "\(fromDate)",
            "toDate": toDate,
//            "user":"",
            "user": "\(Cache.user!.UserName)",
            "shopCodeEx": "\(shopCodeEx)",
            "shopCodeRec": "\(shopCodeRec)",
            "statusCode": "\(statusCode)",
            "transporter": "\(transporter)",
            "soBillFRT": "\(soBillFRT)",
            
        ]
        debugPrint(parameters)
        
        provider.request(.searchVanDon(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
              
                    let arrJson = json.array ?? []
                 
                    var list:[VanDon] = []
                    
                    for item in arrJson {
                        let vanChuyenDocEntry = item["vanChuyenDocEntry"].stringValue
                        let soBillFRT = item["soBillFRT"].stringValue
                        let trangThaiDuyet = item["trangThaiDuyet"].stringValue
                        let nguoiDuocDuyet = item["nguoiDuocDuyet"].stringValue
                        let tenNguoiDuyet = item["tenNguoiDuyet"].stringValue
                        
                        let thoiGianDuyet = item["thoiGianDuyet"].stringValue
                        let maNhaVanChuyen = item["maNhaVanChuyen"].stringValue
                        let tenNhaVanChuyen = item["tenNhaVanChuyen"].stringValue
                        
                        let maDichVu = item["maDichVu"].stringValue
                        let tenDichVu = item["tenDichVu"].stringValue
                        
                        let chiPhi = item["chiPhi"].stringValue
                        let maNhaVanChuyenDeXuat = item["maNhaVanChuyenDeXuat"].stringValue
                        let tenNhaVanChuyenDeXuat = item["tenNhaVanChuyenDeXuat"].stringValue
                        let maDichVuDeXuat = item["maDichVuDeXuat"].stringValue
                        let tenDichVuDeXuat = item["tenDichVuDeXuat"].stringValue
                        
                        let chiPhiDeXuat = item["chiPhiDeXuat"].stringValue
                        let shopXuat = item["shopXuat"].stringValue
                        let shopNhan = item["shopNhan"].stringValue
                        let ghiChu = item["ghiChu"].stringValue
                        let tenTrangThai = item["tenTrangThai"].stringValue
                        
                        list.append(VanDon(vanChuyenDocEntry : vanChuyenDocEntry, soBillFRT: soBillFRT, trangThaiDuyet : trangThaiDuyet, nguoiDuocDuyet: nguoiDuocDuyet, tenNguoiDuyet: tenNguoiDuyet,thoiGianDuyet: thoiGianDuyet, maNhaVanChuyen : maNhaVanChuyen, tenNhaVanChuyen: tenNhaVanChuyen, maDichVu : maDichVu, tenDichVu: tenDichVu, chiPhi: chiPhi, maNhaVanChuyenDeXuat: maNhaVanChuyenDeXuat, tenNhaVanChuyenDeXuat : tenNhaVanChuyenDeXuat, maDichVuDeXuat: maDichVuDeXuat, tenDichVuDeXuat : tenDichVuDeXuat, chiPhiDeXuat: chiPhiDeXuat, shopXuat: shopXuat, shopNhan: shopNhan, ghiChu: ghiChu,tenTrangThai:tenTrangThai))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)

                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func approveVanDon(param: RequestApproveVanDon, handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let paramDic = param.dictionary!
        debugPrint(paramDic)
        
        provider.request(.approveVanDon(params:paramDic)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    print(arrJson)
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["msg"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func nhaVanChuyen(handler: @escaping (_ results: [NhaVanChuyen]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.nhaVanChuyen){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
              
                    let arrJson = json.array ?? []
                 
                    var list:[NhaVanChuyen] = []
                    
                    for item in arrJson {
                        let code = item["code"].stringValue
                        let name = item["name"].stringValue
                        list.append(NhaVanChuyen(code : code,name: name))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)

                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func searchShop(handler: @escaping (_ results: [ItemShop]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.searchShop){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
              
                    let arrJson = json.array ?? []
                 
                    var list:[ItemShop] = []
                    
                    for item in arrJson {
                        let code = item["code"].stringValue
                        let name = item["name"].stringValue
                        list.append(ItemShop(code : code,name: name))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)

                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func masterdataWhs(handler: @escaping (_ results: [ItemWhs]) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: Any] = [
            "ShopCode": "\(Cache.user!.ShopCode)",
        ]
        provider.request(.masterdataWhs(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
              
                    let arrJson = json.array ?? []
                 
                    var list:[ItemWhs] = []
                    
                    for item in arrJson {
                        let whsCode = item["whsCode"].stringValue
                        let whsName = item["whsName"].stringValue
                        let u_WHS_TYPE = item["u_WHS_TYPE"].stringValue
                        let u_Code_SH = item["u_Code_SH"].stringValue
                        list.append(ItemWhs(whsCode : whsCode,whsName: whsName,u_WHS_TYPE:u_WHS_TYPE,u_Code_SH:u_Code_SH))
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(list)
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([])
                    print(error.localizedDescription)

                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([])
                print(error.localizedDescription)

            }
        }
    }
    class func checkSOBH(soNum:String, soPhieuBH:String,soycdc:String, noiDung:String, handler: @escaping (_ result:String,_ message:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "user": "\(Cache.user!.ShopCode)",
            "soNum": "\(soNum)",
            "soPhieuBH" : "\(soPhieuBH)",
            "soycdc": "\(soycdc)",
            "noiDung": "\(noiDung)",
            "os":"2"
        ]
        print(parameters)
        
        provider.request(.checkSOBH(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = moyaResponse.data
                    let json = try JSON(data: data)
                    let arrJson = json.array ?? []
                    print(arrJson)
                    if arrJson.count > 0 {
                        let rs = arrJson[0]
                        let result = rs["result"].stringValue
                        let msg = rs["msg"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(result, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("", "", "API Error")
                    }
                } catch (let error) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
}
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    var dictionaryString: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: String] }
    }
}
