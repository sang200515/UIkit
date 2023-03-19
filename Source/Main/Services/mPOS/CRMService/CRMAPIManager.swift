//
//  CRMAPIManager.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver
public class CRMAPIManager{
    // MARK: - GalaxyPay
    class func Galaxy_info_customer(phonenumber: String, handler: @escaping (_ success:InfoCustomerGalaxyPlay?,_ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phonenumber": "\(phonenumber)",
            "userid": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.Galaxy_info_customer(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                
                let success = json?["Success"].bool
                let Messages = json?["Messages"].string
                if(success ?? false){
                    let mData = json!["Data"]
                    let rs = InfoCustomerGalaxyPlay.getObjFromDictionary(data: mData)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, Messages,"")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, Messages, "")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, "", error.localizedDescription)
            }
        }
    }
    class func Galaxy_order_insert(xmlstringpay: String, price_cost: String, price: String, phonenumber: String, productcode: String, productname: String, magoiNCC: String, startdate: String, enddate: String, mota_goi: String, handler: @escaping (_ result: ResultInsertGalaxyPay?,_ message:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userid":"\(Cache.user!.UserName)",
            "shopcode":"\(Cache.user!.ShopCode)",
            "xmlstringpay":"\(xmlstringpay)",
            "price_cost":"\(price_cost)",
            "price":"\(price)",
            "phonenumber":"\(phonenumber)",
            "devicetype":"2",
            "productcode":"\(productcode)",
            "productname":"\(productname)",
            "magoiNCC":"\(magoiNCC)",
            "startdate":"\(startdate)",
            "enddate":"\(enddate)",
            "mota_goi":"\(mota_goi)"
        ]
        print(parameters)
        provider.request(.Galaxy_order_insert(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                let success = json?["Success"].bool
                let Messages = json?["Messages"].string
                if(success ?? false){
            
                    guard let dictionary = json?["Data"].rawValue as? [String:AnyObject] else {return}
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(ResultInsertGalaxyPay(dictionary: dictionary),Messages ?? "LOAD API ERROR","")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,Messages ?? "LOAD API ERROR !", Messages ?? "LOAD API ERROR !")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,"", error.localizedDescription)
            }
        }
    }
    class func Galaxy_order_history(handler: @escaping (_ success:[OrderHistoryGalaxyPlay],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userid": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)"
        ]
        print(parameters)
        provider.request(.Galaxy_order_history(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                
                let success = json?["Success"].bool
                let Messages = json?["Messages"].string
                if(success ?? false){
                    let mData = json?["Data"].array ?? []
                    let rs = OrderHistoryGalaxyPlay.parseObjfromArray(array: mData)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], Messages ?? "LOAD API ERROR")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func Galaxy_order_detais(docentry: String, handler: @escaping (_ lstOrder:[OrderHistoryGalaxyPlay],_ orct:OrctGalaxyPay?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let log = SwiftyBeaver.self
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "userid": "\(Cache.user!.UserName)",
            "shopcode": "\(Cache.user!.ShopCode)",
            "docentry": "\(docentry)"
        ]
        print(parameters)
        log.debug(parameters)
        provider.request(.Galaxy_order_detais(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                log.debug(json as Any)
                let success = json?["Success"].bool
                let Messages = json?["Messages"].string
                if(success ?? false){
                    let mData = json?["Data"]
                    let mDataDetail = mData?["detais"].array ?? []
                    let lstOrder = OrderHistoryGalaxyPlay.parseObjfromArray(array: mDataDetail)
                    
        
                    let dictionaryOrct = mData?["orct"][0].rawValue as? [String:AnyObject]
                    let orct = OrctGalaxyPay(dictionary: dictionaryOrct ?? [:])
                    
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(lstOrder,orct,"")
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([],nil, Messages ?? "LOAD API ERROR!")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([],nil, error.localizedDescription)
            }
        }
    }
    
    class func pushBillThuHoGalaxyPay(printBill:BillParamGalaxyPay) {
        let log = SwiftyBeaver.self
        log.debug("\(String(describing: printBill.toJSON))")
        let mn = Config.manager
        
        let action = "\(Cache.user!.ShopCode)/push"
        let urlString = "\(mn.URL_PRINT_BILL!)/api/\(action)"
        let manager = Alamofire.Session.default
        if let data =  try? JSONSerialization.data(withJSONObject: printBill.toJSON(), options: []){
            if let jsonData = String(data:data, encoding:.utf8) {
                print(jsonData)
                let billParam = BillParam(title: "Thu hộ Galaxy", body: jsonData,id: "POS", key: "pos_thuho_galaxy")
                let billMessage = BillMessage(message:billParam)
                
                if let data2 =  try? JSONSerialization.data(withJSONObject: billMessage.toJSON(), options: []){
                    if let url = URL(string: urlString) {
                        var request = URLRequest(url: url)
                        request.httpMethod = HTTPMethod.post.rawValue
                        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                        request.httpBody = data2
                        manager.request(request).responseJSON {
                            (response) in
                            print(response)
                        }
                    }
                }
            }
        }
    }
    
    class func GetSurveyQuestion(handler: @escaping (_ success:[ItemKhaoSatMienTrung],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "company": "Fptshop",
            "EmployeeCode": "\(Cache.user?.UserName ?? "")"
        ]
        
        print(parameters)
        provider.request(.GetSurveyQuestion(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data).array ?? []
                    print(json)
                    let rs = ItemKhaoSatMienTrung.parseObjfromArray(array: json)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func Survey_SaveData(arrKhaoSat: [ItemKhaoSatResult], handler: @escaping (_ success:Int, _ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        var arrParamKhaoSat = [[String:String]]()
        for item in arrKhaoSat {
            let dict:[String:String] = ["value":"\(item.itemValue)", "description":"\(item.itemDescription)"]
            arrParamKhaoSat.append(dict)
        }
        
        let mdata = try! JSONSerialization.data(withJSONObject: arrParamKhaoSat, options: [])
        
        print(arrParamKhaoSat)
        provider.request(.Survey_SaveData(jsonBatch: mdata)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data).array ?? []
                    print(json)
                    
                    if json.count > 0 {
                        let rs = json[0]
                        let rsCode = rs["status"].intValue
                        let message = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, message, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "API ERROR")
                    }
                    
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func uploadImageUrl(strBase64: String,folder: String = "FRT_BIRTHDAY_VOUCHER", filename: String, handler: @escaping (_ url:String,_ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "base64": "\(strBase64)",
            "folder": folder,
            "filename": "\(filename)"
        ]
        
        print(parameters)
        provider.request(.uploadImageUrl(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let message = json["message"].stringValue
                    let urlString = json["url"].stringValue
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(urlString, message, "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
                case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Voucher_Birthday_History(keysearch: String, handler: @escaping (_ success:[LapTopBirthdayHistory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "shopcode": "\(Cache.user?.ShopCode ?? "")",
            "userid": "\(Cache.user?.UserName ?? "")",
            "keysearch": "\(keysearch)"
        ]
        
        print(parameters)
        provider.request(.sp_FRT_Voucher_Birthday_History(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let arrJson = json["Data"].array ?? []
                        let rs = LapTopBirthdayHistory.parseObjfromArray(array: arrJson)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }

    class func sp_FRT_Voucher_Birthday_Create(phonenumber: String, idcard: String, fullname: String, birthday_ocr: String, birthday: String, address: String, url_mattruoc: String, url_matsau: String, typecard: String, idcard_ocr: String, handler: @escaping (_ success:Int?,_ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phonenumber":"\(phonenumber)",
            "idcard":"\(idcard)",
            "fullname":"\(fullname)",
            "birthday_ocr":"\(birthday_ocr)",
            "birthday":"\(birthday)",
            "address":"\(address)",
            "issueday":"",
            "url_mattruoc":"\(url_mattruoc)",
            "url_matsau":"\(url_matsau)",
            "typecard":"\(typecard)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")",
            "deviceid":"2",
            "idcard_ocr":"\(idcard_ocr)"
        ]
        
        print(parameters)
        provider.request(.sp_FRT_Voucher_Birthday_Create(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rs = json["Data"]
                        let rsCode = rs["result"].intValue
                        let msg = rs["messages"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func sp_FRT_Voucher_Birthday_Cancel(idItem: String, handler: @escaping (_ success:Int?,_ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "id":"\(idItem)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")"
        ]
        
        print(parameters)
        provider.request(.sp_FRT_Voucher_Birthday_Cancel(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rs = json["Data"]
                        let rsCode = rs["result"].intValue
                        let msg = rs["messages"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
                case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(phonenumber: String, handler: @escaping (_ success:[MobifoneMsalePackage],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phonenumber":"\(phonenumber)"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rsJson = json["Data"].array ?? []
                        let rs = MobifoneMsalePackage.parseObjfromArray(array: rsJson)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_Viettel_Msale_ActiveSim_Getlist(type: String, handler: @escaping (_ success:[Mobifone_Msale_ActiveSim],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "type":"\(type)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")",
            "provider":"Viettel"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Vietel_Msale_ActiveSim_Getlist(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rsJson = json["Data"].array ?? []
                        let rs = Mobifone_Msale_ActiveSim.parseObjfromArray(array: rsJson)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Viettel_Msale_ActiveSim_Confirm(id: String, package_fpt: String, package_name_fpt: String, package_price: String, is_topup: String,providers: String, handler: @escaping (_ rsCode:Int?, _ msg:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "id":"\(id)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")",
            "package_fpt":"\(package_fpt)",
            "package_name_fpt":"\(package_name_fpt)",
            "package_price":"\(package_price)",
            "device_type":"2",
            "is_topup":"\(is_topup)",
            "provider": providers
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Vietel_Msale_ActiveSim_Confirm(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rs = json["Data"]
                        let rsCode = rs["result"].intValue
                        let msg = rs["messages"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    
    class func mpos_FRT_Mobifone_Msale_ActiveSim_Getlist(type: String, handler: @escaping (_ success:[Mobifone_Msale_ActiveSim],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "type":"\(type)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")",
            "provider":"mobifone"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Mobifone_Msale_ActiveSim_Getlist(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rsJson = json["Data"].array ?? []
                        let rs = Mobifone_Msale_ActiveSim.parseObjfromArray(array: rsJson)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(id: String, package_fpt: String, package_name_fpt: String, package_price: String, is_topup: String, handler: @escaping (_ rsCode:Int?, _ msg:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "id":"\(id)",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "userid":"\(Cache.user?.UserName ?? "")",
            "package_fpt":"\(package_fpt)",
            "package_name_fpt":"\(package_name_fpt)",
            "package_price":"\(package_price)",
            "device_type":"2",
            "is_topup":"\(is_topup)",
            "provider": "mobifone"
        ]
        
        print(parameters)
        provider.request(.mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let success = json["Success"].boolValue
                    if success {
                        let rs = json["Data"]
                        let rsCode = rs["result"].intValue
                        let msg = rs["messages"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsCode, msg, "")
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(0, "", "API ERROR")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }

    class func checkPemissionMoMoAPI(handler: @escaping (_ code:String,_ detail:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let params = [
            "userid": Cache.user?.UserName ?? "",
            "shopcode": Cache.user?.ShopCode ?? ""
        ]
        provider.request(.checkPemissionMoMo(params:params)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let Code = json?["Code"].string {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let detail = json?["Detail"].string
                    handler(Code ,detail ?? "LOAD API ERROR !","")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("","","Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("","",error.localizedDescription)

            }
        }
    }
    // MARK: - Itel
    class func Itel_SendOTPUpdate(isdn:String,handler: @escaping (_ ErrorCode:String?,_ error:String) ->Void){
           UIApplication.shared.isNetworkActivityIndicatorVisible = true
           let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
           let parameters: [String: String] = [
               "Msisdn" : "\(isdn)",
               "UserCode":"\(Cache.user!.UserName)",
               "ShopCode":"\(Cache.user!.ShopCode)"
           ]
    
           print(parameters)
           provider.request(.Itel_SendOTPUpdate(params:parameters)){ result in
               switch result {
               case let .success(moyaResponse):
                   let data = moyaResponse.data
                   let json = try? JSON(data: data)
                   print(json as Any)
                   if (json?["ErrorCode"].stringValue) != nil{
                       handler(json!["ErrorCode"].stringValue,json!["ErrorMessage"].stringValue)
                   }else{
                       handler("","LOAD API Itel_SendOTPUpdate Error")
                   }
                   UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
               case let .failure(error):
                   UIApplication.shared.isNetworkActivityIndicatorVisible = false
                   handler(nil, error.localizedDescription)
               }
           }
       }
    
    
    class func UpdateCustomerResult_HDItelecom(p_NgaySinh_KH:String,p_CMND_KH:String,p_NoiCapCMND_KH:String,p_HopDongSo:String,p_TenKH:String,p_QuocGia_KH:String,p_ChuKy:String,p_SoDTLienHe:String,p_NoiThuongTru_KH:String,p_GioiTinh_KH:String,p_NgayCapCMND_KH:String,handler: @escaping (_ success:SimAutoImage?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let log = SwiftyBeaver.self
        let parameters: [String: String] = [
            "p_NVGiaoDich" : "\(Cache.user?.EmployeeName ?? "")",
            "p_NgaySinh_KH": "\(p_NgaySinh_KH)",
            "p_CMND_KH":"\(p_CMND_KH)",
            "p_NoiCapCMND_KH":"\(p_NoiCapCMND_KH)",
            "p_HopDongSo":"\(p_HopDongSo)",
            "p_TenDiemGiaoDich":"\(Cache.user?.Address ?? "")",
            "p_DCGiaoDich":"\(Cache.user?.Address ?? "")",
            "p_TenKH":"\(p_TenKH)",
            "p_MaDiemGD":"\(Cache.user?.ShopCode ?? "")",
            "p_QuocGia_KH":"\(p_QuocGia_KH)",
            "p_ChuKy":"\(p_ChuKy)",
            "p_SoDTLienHe":"\(p_SoDTLienHe)",
            "p_NoiThuongTru_KH":"\(p_NoiThuongTru_KH)",
            "p_GioiTinh_KH":"\(p_GioiTinh_KH)",
            "p_NgayCapCMND_KH":"\(p_NgayCapCMND_KH)"
        ]
        
        log.debug(parameters)
        var imageInfo:SimAutoImage? = nil
        provider.request(.UpdateCustomerResult_HDItelecom(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                log.debug(json!)
                let data1 = json?["CustomerResult_HDItelecom"]
                
                if(!(data1?.isEmpty ?? false)){
                    imageInfo = SimAutoImage.getObjFromDictionary(data: data1!)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(imageInfo,"Load API ERRO")
                }
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(imageInfo,error.localizedDescription)
            }
        }
    }
            
    //    CheckIn_FirstLogin
    class func CheckIn_FirstLogin(handler: @escaping (_ rsCode: Int, _ messages: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "company": "Fptshop",
            "Employcode": "\(Cache.user?.UserName ?? "")"
        ]
        debugPrint(parameters)
        
        provider.request(.CheckIn_FirstLogin(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let rsJson = json.array ?? []
                    if rsJson.count > 0 {
                        let rs = rsJson[0]
                        let rsCode = rs["status"].intValue
                        let messages = rs["message"].stringValue
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let statusCode = moyaResponse.statusCode
                        if(statusCode == 200) {
                            handler(rsCode, messages, "")
                        } else {
                            let errJson = json["message"].string
                            if statusCode == 401 {
                                handler(rsCode, messages, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                            } else {
                                handler(rsCode, messages, "\(errJson ?? "API error")")
                            }
                        }
                    } else {
                        handler(0, "", "data null")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(0, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(0, "", error.localizedDescription)
            }
        }
    }
    //    GetListShiftDateByEmployee
    class func GetListShiftDateByEmployee(handler: @escaping (_ rs: [ShiftDateByEmployee],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Company": "Fptshop",
            "EmployeeCode": "\(Cache.user?.UserName ?? "")"
        ]
        debugPrint(parameters)
        
        provider.request(.GetListShiftDateByEmployee(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                if(moyaResponse.statusCode == 401){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], "401")
                }else{
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        let rsJson = json.array ?? []
                        let rs = ShiftDateByEmployee.parseObjfromArray(array: rsJson)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } catch let error {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler([], error.localizedDescription)
                    }
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    //ITEL
    class func Itel_ChangeIsim(isdn:String,Seri:String,Otp:String, isEsim: String, Doctal: String, FullName: String,handler: @escaping (_ ErrorCode:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Msisdn": isdn,
            "Seri": Seri,
            "Otp": Otp,
            "Esim":"\(isEsim)",
            "Doctal": "\(Doctal)",
            "FullName": "\(FullName)",
            "GhiChu": "",
            "UserCode": Cache.user!.UserName,
            "ShopCode": Cache.user!.ShopCode,
            "ShopName": Cache.user!.ShopName,
            "ShopAddress": Cache.user!.Address,
            "DeviceType": "2",
            "Version": "\(Common.versionApp())"
        ]
        
        print(parameters)
        provider.request(.Itel_ChangeIsim(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if (json?["ErrorCode"].stringValue) != nil{
                    handler(json!["ErrorCode"].stringValue,json!["ErrorMessage"].stringValue)
                }else{
                    handler("","LOAD API Itel_SendOTPUpdate Error")
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func Itel_UpdateSubscriberInfo(Image1:String,Image2:String,Image3:String,Image4:String,Image5:String,Image6:String,Msisdn:String,FullName:String,Birthday:String,IdNumber:String,Address:String,Gender:String,NationalityId:String,LoaiGT:String,NoiCap:String,LoaiKH:String,SoVisa:String,SoVisaHH:String,MaXacThuc:String,PlaceDate:String,CusUse:String,ProvinceCode:String,DistrictCode:String,PrecinctCode:String,Passport:String,handler: @escaping (_ ErrorCode:String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            
            "Image1": "\(Image1)",
            "Image2": "\(Image2)",
            "Image3": "\(Image3)",
            "Image4": "\(Image4)",
            "Image5": "\(Image5)",
            "Image6": "\(Image6)",
            "Msisdn": "\(Msisdn)",
            "FullName": "\(FullName)",
            "Birthday": "\(Birthday)",
            "IdNumber": "\(IdNumber)", //so cmnd
            "Passport": "\(Passport)",
            "Address": "\(Address)",
            "Gender": "\(Gender)",
            "NationalityId": "\(NationalityId)",
            "LoaiGT": "\(LoaiGT)",
            "NoiCap": "\(NoiCap)",
            "LoaiKH": "\(LoaiKH)",
            "SoVisa": "\(SoVisa)",
            "SoVisaHH": "\(SoVisaHH)",
            "MaXacThuc": "\(MaXacThuc)",
            "PlaceDate": "\(PlaceDate)",
            "CusUse": "\(CusUse)",
            "UserCode": "\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "ShopName": "\(Cache.user?.ShopName ?? "")",
            "ShopAddress": "\(Cache.user?.Address ?? "")",
            "DeviceType": "2",
            "Version": "\(Common.versionApp())",
            "ProvinceCode": ProvinceCode,
            "DistrictCode": DistrictCode,
            "PrecinctCode": PrecinctCode
        ]
        
        print(parameters)
        provider.request(.Itel_UpdateSubscriberInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if (json?["ErrorCode"].stringValue) != nil{
                    handler(json!["ErrorCode"].stringValue,json!["ErrorMessage"].stringValue)
                }else{
                    handler("","LOAD API Itel_SendOTPUpdate Error")
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func Itel_GetQrCode(serial:String,handler: @escaping (_ qrcode:String?,_ iccid:String?,_ errMsg: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "serial": serial,
            "format": "png",
            "size": "480",
            "usercode": "\(Cache.user?.UserName ?? "")",
            "shopcode": "\(Cache.user?.ShopCode ?? "")"
        ]
        
        print(parameters)
        provider.request(.Itel_GetQrCode(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                
                let errCode = json?["code"].string
                let errMsg = json?["message"].string
                let jsonData = json?["data"]
                
                if errCode == "SUCCESS" {
                    if jsonData != nil {
                        let qrcode = jsonData!["data"].stringValue
                        let iccid = jsonData!["iccid"].stringValue
                        handler(qrcode, iccid, "", "")
                    } else {
                        let errMsg = json?["message"].string
                        handler("", "", errMsg ?? "API Error", "")
                    }
                } else {
                    handler("", "", errMsg ?? "API Error", "")
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil,nil, "", error.localizedDescription)
            }
        }
    }
    class func Itel_GetChangeSimFee(PhoneNumber:String,isEsim: String, handler: @escaping (_ success:GetSimFeeItel?,_ ErrorCode: String,_ ErrorMessage: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "PhoneNumber": PhoneNumber,
            "UserCode": "\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "DeviceType": "2",
            "Version": "\(Common.versionApp())",
            "IsEsim": isEsim
        ]
        
        print(parameters)
        provider.request(.Itel_GetChangeSimFee(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let mData = json["Data"]
                    
                    let rs = GetSimFeeItel.getObjFromDictionary(data: mData)
                    let ErrorCode = json["ErrorCode"].stringValue
                    let ErrorMessage = json["ErrorMessage"].stringValue
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, ErrorCode, ErrorMessage, "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, "", "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, "", "", error.localizedDescription)
            }
        }
    }
    class func Itel_GetUpdateSubInfoHistory(PhoneNumber:String, handler: @escaping (_ success:[SimItelHistory],_ ErrorCode: String,_ ErrorMessage: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phoneNumber": PhoneNumber,
            "usercode": "\(Cache.user?.UserName ?? "")",
            "shopcode": "\(Cache.user?.ShopCode ?? "")",
            "deviceType": "2",
            "version": "\(Common.versionApp())"
        ]
        
        print(parameters)
        provider.request(.Itel_GetUpdateSubInfoHistory(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let mData = json["Data"].array ?? []
                    let ErrorCode = json["ErrorCode"].stringValue
                    let ErrorMessage = json["ErrorMessage"].stringValue
                    let rs = SimItelHistory.parseObjfromArray(array: mData)
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs, ErrorCode, ErrorMessage, "")
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], "", "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], "", "", error.localizedDescription)
            }
        }
    }
    class func PG_loadcheckinbywarehouse(fromdate: String, todate: String, handler: @escaping (_ rs: [PGCheckIn],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "fromdate": "\(fromdate)".encodeString(),
            "todate": "\(todate)".encodeString(),
            "warehousecode": "\(Cache.user?.ShopCode ?? "")"
        ]
        debugPrint(parameters)
        
        provider.request(.PG_loadcheckinbywarehouse(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rsJson = json.array ?? []
                        let rs = PGCheckIn.parseObjfromArray(array: rsJson)
                        handler(rs, "")
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler([], "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else {
                            handler([], "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_GetMainInfo(handler: @escaping (_ success: ViettelPayNccInfo?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "_includeDetails": "true"
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_GetMainInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelPayNccInfo.getObjFromDictionary(data: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler(nil, "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_CreateOrder(requestId: String, responseId: String, otp: String, keyOtpFee: String, senderName: String, senderPhone: String, receiveName: String, receivePhone:String, providerId: String, productId: String, price: String, totalAmount: String, totalAmountIncludingFee: String, totalFee: String, creationTime: String, categoryId: String, descriptionNote: String, handler: @escaping (_ rsID: String, _ customerId: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let dict_ReferenceIntegrationInfo:[String:String] = ["requestId": "\(requestId)",
                                                             "responseId": "\(responseId)"]
        let dict_ExtraProperties:[String:Any] = ["referenceIntegrationInfo": dict_ReferenceIntegrationInfo,
                                                 "warehouseName": "\(Cache.user?.ShopName ?? "")",
                                                 "otp": "\(otp)",
                                                 "keyOtpFee": "\(keyOtpFee)"]
        
        let dict_sender:[String:String] = ["fullname": "\(senderName)",
                                           "phonenumber": "\(senderPhone)"]
        let dict_receiver:[String:String] = ["fullname": "\(receiveName)",
                                             "phonenumber": "\(receivePhone)"]
        let dict_productConfigDto:[String:Any] = ["checkInventory": false]
        
        let dict_orderTransactionDtos:[String:Any] = ["productId": "\(productId)",
                                                      "providerId": "\(providerId)",
                                                      "providerName": "Viettel",
                                                      "productName": "Nạp tiền tài khoản Viettel Pay",
                                                      "price": "\(price)",
                                                      "quantity": 1,
                                                      "totalAmount": "\(totalAmount)",
                                                      "totalAmountIncludingFee": "\(totalAmountIncludingFee)",
                                                      "totalFee": "\(totalFee)",
                                                      "creationTime": "\(creationTime)",
                                                      "creationBy": "\(Cache.user?.UserName ?? "")",
                                                      "integratedGroupCode": "TOPUP",
                                                      "integratedGroupName": "",
                                                      "integratedProductCode": "TRANSFER",
                                                      "integratedProductName": "",
                                                      "isOfflineTransaction": false,
                                                      "referenceCode": "",
                                                      "minFee": 0,
                                                      "maxFee": 0,
                                                      "percentFee": 0,
                                                      "constantFee": 0,
                                                      "paymentFeeType": 0,
                                                      "paymentRule": 0,
                                                      "productCustomerCode": "\(receivePhone)",//chu acc viettelPay
                                                      "productCustomerName": "\(receiveName)",
                                                      "productCustomerPhoneNumber": "\(receivePhone)",
                                                      "productCustomerAddress": "",
                                                      "productCustomerEmailAddress": "",
                                                      "description": "\(descriptionNote)",
                                                      "vehicleNumber": "",
                                                      "invoices": [],
                                                      "categoryId": "\(categoryId)",
                                                      "isExportInvoice": false,
                                                      "id": "",
                                                      "extraProperties": dict_ExtraProperties,
                                                      "sender": dict_sender,
                                                      "receiver": dict_receiver,
                                                      "productConfigDto": dict_productConfigDto ]
        
        var arr_orderTransactionDtos = [[String:Any]]()
        arr_orderTransactionDtos.append(dict_orderTransactionDtos)
        
        let dict_payments:[String:String] = ["paymentType": "1",
                                             "paymentValue": "\(totalAmountIncludingFee)",//tien + phí
                                             "paymentExtraFee": "0",
                                             "paymentPercentFee": "0"]
        var arr_payments = [[String:Any]]()
        arr_payments.append(dict_payments)
        
        let parameters: [String: Any] = [
            "orderStatus": 1,
            "orderStatusDisplay": "",
            "billNo": "",
            "customerId": "",
            "customerName": "\(senderName)", //nguoi thanhtoan
            "customerPhoneNumber": "\(senderPhone)",
            "warehouseCode": "\(Cache.user?.ShopCode ?? "")",
            "regionCode": "",
            "creationBy": "\(Cache.user?.UserName ?? "")",
            "creationTime": "\(creationTime)",
            "referenceSystem": "MPOS",
            "referenceValue": "",
            "orderTransactionDtos": arr_orderTransactionDtos,
            "payments": arr_payments,
            "id": "",
            "ip": ""
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_CreateOrder(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    
                    if statusCode == 200 {
                        let rsID = json["id"].stringValue
                        let customerId = json["customerId"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsID, customerId, "")
                    } else if statusCode == 401 {
                        handler("", "", "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler("", "", "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_GetFee(senderName: String, senderPhone: String, amount: String, subject: String, providerId: String, productId: String, otp: String, keyOtpFee: String, handler: @escaping (_ success: ViettelPayNapTien?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let dict_sender:[String:String] = ["phoneNumber": "\(senderPhone)",
                                           "name": "\(senderName)"]
        let dict_extraProperties:[String:Any] = ["integrationAction": "get-fee",
                                                 "amount": "\(amount)",
                                                 "sender": dict_sender,
                                                 "otp": "\(otp)",
                                                 "keyOtpFee": "\(keyOtpFee)"]
        
        let parameters: [String: Any] = [
            "providerId": "\(providerId)",
            "productId": "\(productId)",
            "subject": "\(subject)",
            "extraProperties": dict_extraProperties
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_GetFee(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelPayNapTien.getObjFromDictionary(data: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler(nil, "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_GetOTP_NapChinhMinh(senderName: String, senderPhone: String, amount: String, subject: String, providerId: String, productId: String,  handler: @escaping (_ success: ViettelPayNapTien?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let dict_sender:[String:String] = ["phoneNumber": "\(senderPhone)",
                                           "name": "\(senderName)"]
        let dict_extraProperties:[String:Any] = ["amount": "\(amount)",
                                                 "sender": dict_sender]
        
        let parameters: [String: Any] = [
            "providerId": "\(providerId)",
            "productId": "\(productId)",
            "subject": "\(subject)",
            "extraProperties": dict_extraProperties
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_GetOTP_NapChinhMinh(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelPayNapTien.getObjFromDictionary(data: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler(nil, "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_CheckOrderStatus(orderId: String,handler: @escaping (_ orderStatus: CreateOrderResultViettelPay_SOM, _ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "orderId":"\(orderId)",
            "integratedGroupCode":"TOPUP"
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_CheckOrderStatus(params:parameters)){ result in
            
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let orderStatus = json["orderStatus"].intValue
                        let msg = json["message"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(CreateOrderResultViettelPay_SOM(rawValue: orderStatus) ?? .FAILED, msg, "")
                    } else if statusCode == 401 {
                        handler(CreateOrderResultViettelPay_SOM(rawValue: 3) ?? .FAILED, "", "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler(CreateOrderResultViettelPay_SOM(rawValue: 3) ?? .FAILED, "", "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(CreateOrderResultViettelPay_SOM(rawValue: 3) ?? .FAILED, "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(CreateOrderResultViettelPay_SOM(rawValue: 3) ?? .FAILED, "", error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_GetOrderInfo(orderId: String, handler: @escaping (_ rs: ViettelPayOrder?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "id":"\(orderId)"
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_GetOrderInfo(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelPayOrder.getObjFromDictionary(data: json)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler(nil, "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
    class func PG_loadinfopg(personalid: String, handler: @escaping (_ rs: [PGInfo],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "personalid": "\(personalid)",
            "warehousecode": "\(Cache.user?.ShopCode ?? "")"
        ]
        debugPrint(parameters)
        
        provider.request(.PG_loadinfopg(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rsJson = json.array ?? []
                        if rsJson.count > 0 {
                            let dataJson = rsJson[0]
                            let mData = dataJson["data"].array ?? []
                            let rs = PGInfo.parseObjfromArray(array: mData)
                            handler(rs, "")
                        } else {
                            handler([], "Data null")
                        }
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler([], "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        }  else {
                            handler([], "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func PG_sendpasswordpg(personalid: String, handler: @escaping (_ rs: String,_ msg: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "personalid": "\(personalid)"
        ]
        debugPrint(parameters)
        
        provider.request(.PG_sendpasswordpg(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rsJson = json.array ?? []
                        if rsJson.count > 0 {
                            let dataJson = rsJson[0]
                            let password = dataJson["password"].stringValue
                            let message = dataJson["message"].stringValue
                            handler(password, message, "")
                        } else {
                            handler("", "", "API Error: response null")
                        }
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler("", "", "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else {
                            handler("", "", "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func ViettelPay_SOM_GetHistory(fromDate: String, toDate: String, parentCategoryIds: String, handler: @escaping (_ rs: [ViettelPaySOMHistory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "term":"creationBy%26%2358; \(Cache.user?.UserName ?? "")",
            "warehouseCode":"\(Cache.user?.ShopCode ?? "")",
            "fromDate":"\(fromDate)",
            "toDate":"\(toDate)",
            "parentCategoryIds":"\(parentCategoryIds)"
        ]
        
        print(parameters)
        provider.request(.ViettelPay_SOM_GetHistory(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelPaySOMHistory.parseObjfromArray(array: json.arrayValue)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler([], "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    } else {
                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        handler([], "Error \(errorSom.rsCode): \(errorSom.message)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func PG_loadcheckinbypersonalid(fromdate: String, todate: String, personalid: String, handler: @escaping (_ rs: [PGCheckIn],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "fromdate": "\(fromdate)".encodeString(),
            "todate": "\(todate)".encodeString(),
            "personalid": "\(personalid)"
        ]
        debugPrint(parameters)
        
        provider.request(.PG_loadcheckinbypersonalid(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rsJson = json.array ?? []
                        let rs = PGCheckIn.parseObjfromArray(array: rsJson)
                        handler(rs, "")
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler([], "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else {
                            handler([], "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func PG_pgoffnhanvien(personalid: String, handler: @escaping (_ success: String, _ msg: String?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "personalid": "\(personalid)"
        ]
        debugPrint(parameters)
        
        provider.request(.PG_pgoffnhanvien(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rsJson = json.array ?? []
                        if rsJson.count > 0 {
                            let rs = rsJson[0]
                            let status = rs["status"].stringValue
                            let msg = rs["message"].stringValue
                            handler(status, msg, "")
                        } else {
                            handler("false", "", "")
                        }
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler("false", "", "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else {
                            handler("false", "", "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("false", "", error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("false", "", error.localizedDescription)
            }
        }
    }
    class func Mobifone_GetlistTopup(phoneNumber: String,handler: @escaping (_ result: [GetTopUpListResult],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            "phoneNumber" : phoneNumber,
            "shopCode" : "\(Cache.user?.ShopCode ?? "")",
            "userCode" : "\(Cache.user?.UserName ?? "")"
        ]
        var rs:[GetTopUpListResult] = []
        provider.request(.Mobifone_GetlistTopup(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                
                do {
                    let json = try JSON(data: data)
                    print(json)
                    if let success = json["Success"].bool {
                        if(success){
                            if let data = json["Data"].array {
                                rs = GetTopUpListResult.parseObjfromArray(array: data)
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
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
//    ViettelVAS_GetMainInfo
    class func ViettelVAS_GetMainInfo(handler: @escaping (_ success: [ViettelVASInfo], _ totalCount: Int,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "Enabled": "true",
            "ParentId": "9de91c80-4b2a-43da-bf33-cf054ef36a2d",
            "_includeDetails": "true"
        ]
        debugPrint(parameters)

        provider.request(.ViettelVAS_GetMainInfo(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rs = ViettelVASInfo.parseArrayFromJson(data: json["items"].arrayValue)
                        let totalCount = json["totalCount"].intValue
                        handler(rs, totalCount, "")
                    } else {
                        let errJson = json["message"].string
                        if statusCode == 401 {
                            handler([], 0, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else if statusCode == 400 {
                            handler([], 0, "\(errJson ?? "header no Token")\nNeed to login again.")
                        } else {
                            handler([], 0, "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], 0, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], 0, error.localizedDescription)
            }
        }
    }
//    ViettelVAS_GetListGoiCuoc
    class func ViettelVAS_GetListGoiCuoc(providerId: String, sdt: String, handler: @escaping (_ success: ViettelVASGoiCuoc?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "providerId": "\(providerId)",
            "customer": "\(sdt)"
        ]
        debugPrint(parameters)

        provider.request(.ViettelVAS_GetListGoiCuoc(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rs = ViettelVASGoiCuoc.getObjectFromJson(data: json)
                        handler(rs, "")
                    } else {
                        let errJson = json["error"]["message"].string
                        if statusCode == 401 {
                            handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else if statusCode == 400 {
                            handler(nil, "\(errJson ?? "header no Token")\nNeed to login again.")
                        } else {
                            handler(nil, "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
//    ViettelVAS_GetOTP
    class func ViettelVAS_GetOTP(providerId: String, sdt: String, productType: String, productCode: String, handler: @escaping (_ success: ViettelVASGoiCuoc?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "providerId": "\(providerId)",
            "customer": "\(sdt)",
            "productType": "\(productType)",
            "productCode": "\(productCode)"
        ]
        debugPrint(parameters)

        provider.request(.ViettelVAS_GetOTP(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                    let statusCode = moyaResponse.statusCode
                    if(statusCode == 200) {
                        let rs = ViettelVASGoiCuoc.getObjectFromJson(data: json)
                        handler(rs, "")
                    } else {
                        let errJson = json["error"]["message"].string
                        if statusCode == 401 {
                            handler(nil, "\(errJson ?? "Invalid Token")\nNeed to login again.")
                        } else if statusCode == 400 {
                            handler(nil, "\(errJson ?? "header no Token")\nNeed to login again.")
                        } else {
                            handler(nil, "\(errJson ?? "API Error")")
                        }
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil, error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
            }
        }
    }
//    ViettelVAS_CreateOrder
    class func ViettelVAS_CreateOrder(providerId: String, sdt: String, creationTime: String, itemGoiCuocMain: ViettelVAS_Product, itemGoiCuocSelect: ViettelVASGoiCuoc_products, payments: [ViettelPayOrder_Payment], totalFee: String,totalAmountIcludeFee: Int, categoryId: String, integrationInfo:ViettelVASGoiCuoc_IntegrationInfo, otpString: String, handler: @escaping (_ rsID: String, _ customerId: String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let arrDict_payments: [[String:Any]] = ViettelPayOrder_Payment.convertTodict(from: payments)
        
        let dict_orderTransactionDtos: [String:Any] = ["productId": "\(itemGoiCuocMain.id)",
                                                       "providerId": "\(itemGoiCuocMain.details.providerID)",
                                                       "providerName": "Viettel-TVBH",
                                                       "productName": "\(itemGoiCuocMain.name)",
                                                       "price": "\(itemGoiCuocMain.details.price)",
                                                       "sellingPrice": "\(itemGoiCuocMain.details.sellingPrice)",
                                                       "quantity": 1,
                                                       "totalAmount": "\(itemGoiCuocMain.details.price)",
                                                       "totalAmountIncludingFee": "\(totalAmountIcludeFee)",
                                                       "totalFee": "\(totalFee)",
                                                       "creationTime": "\(creationTime)",
                                                       "creationBy": "\(Cache.user?.UserName ?? "")",
                                                       "integratedGroupCode": "\(itemGoiCuocMain.configs[0].integratedGroupCode)",
                                                       "integratedGroupName": "",
                                                       "integratedProductCode": "\(itemGoiCuocMain.configs[0].integratedProductCode)",
                                                       "integratedProductName": "",
                                                       "isOfflineTransaction": false,
                                                       "referenceCode": "",
                                                       "minFee": 0,
                                                       "maxFee": 0,
                                                       "percentFee": 0,
                                                       "constantFee": 0,
                                                       "paymentFeeType": 0,
                                                       "paymentRule": 0,
                                                       "productCustomerCode": "\(sdt)",
                                                       "productCustomerName": "",
                                                       "productCustomerPhoneNumber": "\(sdt)",
                                                       "productCustomerAddress": "",
                                                       "productCustomerEmailAddress": "",
                                                       "description": "",
                                                       "vehicleNumber": "",
                                                       "invoices": [],
                                                       "categoryId": "\(categoryId)",
                                                       "isExportInvoice": false,
                                                       "id": "",
                                                       "extraProperties": [
                                                           "referenceIntegrationInfo": [
                                                            "requestId": "\(integrationInfo.requestId)",
                                                            "responseId": "\(integrationInfo.responseId)"
                                                           ],
                                                        "warehouseName": "\(Cache.user?.ShopName ?? "")",
                                                        "type": "\(itemGoiCuocSelect.type)",
                                                           "otp": "\(otpString)"
                                                       ],
                                                       "sender": [:],
                                                       "receiver": [:],
                                                       "productConfigDto": ["checkInventory": false]]
        var arr_orderTransactionDtos = [[String:Any]]()
        arr_orderTransactionDtos.append(dict_orderTransactionDtos)
        
        let parameters: [String: Any] = [
            "orderStatus": 1,
            "orderStatusDisplay": "",
            "billNo": "",
            "customerId": "",
            "customerName": "",
            "customerPhoneNumber": "\(sdt)",
            "warehouseCode": "\(Cache.user?.ShopCode ?? "")",
            "regionCode": "",
            "creationBy": "\(Cache.user?.UserName ?? "")",
            "creationTime": "\(creationTime)",
            "referenceSystem": "MPOS",
            "referenceValue": "",
            "orderTransactionDtos": arr_orderTransactionDtos,
            "payments": arrDict_payments,
            "id": "",
            "ip": ""
        ]
        debugPrint(parameters)

        provider.request(.ViettelVAS_CreateOrder(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    
                    if statusCode == 200 {
                        let rsID = json["id"].stringValue
                        let customerId = json["customerId"].stringValue
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rsID, customerId, "")
                    } else if statusCode == 401 {
                        handler("", "", "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    }
                    else {
//                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
                        let errSom = json["error"]
                        handler("", "", "Error : \(errSom["message"].stringValue)")
                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("", "", error.localizedDescription)
                }

            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", "", error.localizedDescription)
            }
        }
    }
    class func ViettelVAS_GetHistory(fromDate: String, toDate: String, parentCategoryIds: String, handler: @escaping (_ rs: [ViettelVASHistory],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<CRMAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "term":"creationBy%26%2358; \(Cache.user?.UserName ?? "")",
            "warehouseCode":"\(Cache.user?.ShopCode ?? "")",
            "fromDate":"\(fromDate)",
            "toDate":"\(toDate)",
            "parentCategoryIds":"\(parentCategoryIds)"
        ]
        
        print(parameters)
        provider.request(.ViettelVAS_GetHistory(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let json = try JSON(data: data)
                    print(json)
                    let statusCode = moyaResponse.statusCode
                    let errJson = json["message"].string
                    if statusCode == 200 {
                        let rs = ViettelVASHistory.parseObjfromArray(array: json.arrayValue)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs, "")
                    } else if statusCode == 401 {
                        handler([], "\(errJson ?? "Invalid Token")\nNeed to login again.")
                    }
//                    else {
//                        let errorSom = ErrorFormat_SOM.getObjFromDictionary(data: json["error"])
//                        handler([], "Error \(errorSom.rsCode): \(errorSom.message)")
//                    }
                } catch let error {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler([], error.localizedDescription)
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
}
