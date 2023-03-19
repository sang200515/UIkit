//
//  MDeliveryAPIService.swift
//  Fpharmacy
//
//  Created by sumi on 6/9/17.
//  Copyright © 2017 sumi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyBeaver

class MDeliveryAPIService: NSObject {
    private static var _defaults = UserDefaults.standard
    static let headers: HTTPHeaders = [
        "Authorization": "Basic bVZpbmFtaWxrU2VydmljZV9LZXk=",
        "Accept": "application/json"
    ]
    
    static let headers2: HTTPHeaders = [
        "Authorization": "Basic Zm1lZGljaW5lOmZtZWRpY2luZUBBcGkxMjM=",
        "Accept": "application/json"
    ]
    
    static let headersUploadImage: HTTPHeaders = [
        "Authorization": "Basic bXBvc2NybTptcG9zY3JtQEFwaTEyMw==",
        "Accept": "application/json"
    ]
    
    class func CheckTokenResult(UserID: String,ToKen: String, completion: @escaping(_ result: Int, _ message: String)->Void)
    {
        //
 
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        //
        let url = URLs.checkTOKEN_Gateway ;
        let parameters = ["UserID" : UserID,"ToKen" : ToKen,"SysType":"3"]
        debugPrint(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(0,error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                
                let taskData = json["Data"]
                let jsonObject = taskData;
                print("CheckTokenResult \(jsonObject)")
                if(jsonObject.count > 0)
                {
                    let rs = jsonObject[0]["Result"].intValue
                    let message = jsonObject[0]["Message"].stringValue
                    completion(rs,message)
                }
                else
                {
                    completion(0,"LOAD API ERRO")
                }
            }
        }
        
    }

    
    /*
     1 Giao hàng tại nhà
     5 Giao hàng tại nhà Ecom/F-Friends Credit
     6 Trả góp qua ngân hàng
     7 Trả góp qua nhà tài chính
     8 Đơn hàng máy cũ
     10 Biên bản Giao nhận Trả góp
     */
    
    class func GetSOByUser(p_User: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GetSOByUserResult])->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getSOByUser_Gateway
        let log = SwiftyBeaver.self
        let parameters = ["UserID" : p_User,"TypeAPP" : "1","SysType":"0","ToKen":Cache.user!.Token]
        log.info(url)
        log.info(headers_Gateway)
        log.info(parameters)
       
        var list:[GetSOByUserResult] = []
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                log.debug(error)
                completion(error,false,[])
            case .success(let value):
                let json = JSON(value)
                log.info(json)
           
                let taskData = json["data"];
                for i in 0..<taskData.count
                {
                    let jsonObject = taskData[i];
                    let getSelectFromObject = GetSOByUserResult.init(GetSOByUserResult: jsonObject)
                    list.append(getSelectFromObject)
                }
                completion(nil,true,list)
            }
        }
    }
    
    
    
    class func GetUserDelivery(shopCode: String, jobtitle:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GetEmPloyeesResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = Config.manager.URL_GATEWAY + "/mpos-cloud-delivery" + "/api/delivery/getemployees" + "?shopCode=\(shopCode)&jobtitle=\(jobtitle)"
        let log = SwiftyBeaver.self
        log.debug(url)
       
        var list:[GetEmPloyeesResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
                
                for i in 0..<json.count
                {
                    let jsonObject = json[i];
                    let getSelectFromObject = GetEmPloyeesResult.init(GetEmPloyeesResult: jsonObject)
                    list.append(getSelectFromObject)
                }
                completion(nil,true,list)
            }
        }
    }
    class func GetConfirmThuKho(docNum: String, userCode:String, password:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let passEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = URLs.getConfirmThuKho_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&password=\(passEncoded)"
    
        let log = SwiftyBeaver.self
        log.debug(url)
      
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
               
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    
    
    class func GetDataGoogleAPIRoute(mLatUser:String , mLongUser:String ,mLat: String,mLong: String,SO:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?,_ resultDistance: String?,_ resultDuration: String?)->Void)
    {
        
        
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(mLatUser),\(mLongUser)&destination=\(mLat),\(mLong)&key=AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU&mode=driving&sensor=false"
//        print("GetDataGoogleAPITime \(url)")
        
        //
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-mdelpharbeta/api/Place/mdel_googleapi_directions"
        log.debug(url)
        //print("GetDataGoogleAPITime \(url)")
        let parameters = ["UserID":"\(Helper.getUserName()!)",
            "ShopCode":"\(Helper.getShopCode()!)",
        "DeviceType": "2",
        "origin":"\(mLatUser),\(mLongUser)",
            "destination":"\(mLat),\(mLong)",
            "key":"AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU",
            "mode":"driving",
            "sensor": "false",
            "SO":"\(SO)",
            "Sys":"fptshop"]
        //print(parameters)
        log.debug(parameters)
        //
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil,nil,nil)
            case .success(let value):
//                if response.result.value != nil {
//                    let json = JSON(value)
//                    let jsonRoute =  json["routes"]
//                    let jsonRouteObject = jsonRoute[0];
//                    let jsonPolyline = jsonRouteObject["overview_polyline"]
//                    let jsonPolylineObject = jsonPolyline["points"]
//
//                    let jsonDistance = jsonRouteObject["legs"][0]["distance"]["text"]
//                    let jsonDuration = jsonRouteObject["legs"][0]["duration"]["text"]
//
//                    print("GetDataGoogleAPITimePoint \(jsonPolylineObject) \(jsonDistance) \(jsonDuration)")
//                    completion(nil,true,"\(jsonPolylineObject)","\(jsonDistance)","\(jsonDuration)")
                    let json = JSON(value)
                    let jsonRoute =  json["routes"]
                    let jsonRouteObject = jsonRoute[0];
                    let jsonPolyline = jsonRouteObject["overview_polyline"]
                    let jsonPolylineObject = jsonPolyline["points"]

                   
                    
                    let jsonDistance = jsonRouteObject["legs"][0]["distance"]["text"].stringValue
                    let jsonDuration = jsonRouteObject["legs"][0]["duration"]["value"]
                    
                    print("GetDataGoogleAPITimePoint \(jsonPolylineObject) \(jsonDistance) \(jsonDuration)")
                    completion(nil,true,"\(jsonPolylineObject)","\(jsonDistance)","\(jsonDuration)")
//                }
                
                
            }
        }
        
    }
    
    //////
    class func GetDataGoogleAPIByAddress(mLatUser:String , mLongUser:String ,mAddress: String,SO:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?,_ resultLat: String?,_ resultLong: String?,_ resultDistance: String?,_ resultDuration: String?)->Void)
    {
        
        
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(mLatUser),\(mLongUser)&destination=\(mAddress)&key=AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU&mode=driving&sensor=false"
//        print("GetDataGoogleAPITime \(url)")
        //
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-mdelpharbeta/api/Place/mdel_googleapi_directions"
        print("GetDataGoogleAPITime \(url)")
        let parameters = ["UserID":"\(Helper.getUserName()!)",
            "ShopCode":"\(Helper.getShopCode()!)",
        "DeviceType": "2",
        "origin":"\(mLatUser),\(mLongUser)",
            "destination":"\(mAddress)",
            "key":"AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU",
            "mode":"driving",
            "sensor": "false",
            "SO":"\(SO)",
            "Sys":"fptshop"]
        print(parameters)
        //
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil,nil,nil,nil,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    let jsonRoute =  json["routes"]
                    let jsonRouteObject = jsonRoute[0];
                    let jsonPolyline = jsonRouteObject["overview_polyline"]
                    let jsonPolylineObject = jsonPolyline["points"]
                    
                    
                    let jsonEnd_address = jsonRouteObject["legs"][0]["end_location"]
                    let mLat = jsonEnd_address["lat"]
                    let mLong = jsonEnd_address["lng"]
                    
                    let jsonDistance = jsonRouteObject["legs"][0]["distance"]["text"]
                    let jsonDuration = jsonRouteObject["legs"][0]["duration"]["text"]
                    
                    print("GetDataGoogleAPITimePoint \(jsonPolylineObject) \(jsonDistance) \(jsonDuration)")
                    completion(nil,true,"\(jsonPolylineObject)","\(mLat)","\(mLong)","\(jsonDistance)","\(jsonDuration)")
//                }
                
                
            }
        }
        
    }
    class func GetDataGoogleAPIByAddressAndAddress(mLatUser:String , mLongUser:String ,mLat: String,SO:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?,_ resultLat: String?,_ resultLong: String?,_ resultDistance: String?,_ resultDuration: String?)->Void)
    {
        
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-mdelpharbeta/api/Place/mdel_googleapi_directions"
        print("GetDataGoogleAPITime \(url)")
        let parameters = ["UserID":"\(Helper.getUserName()!)",
            "ShopCode":"\(Helper.getShopCode()!)",
            "DeviceType": "2",
            "origin":"\(mLatUser),\(mLongUser)",
            "destination":"\(mLat)",
            "key":"AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU",
            "mode":"driving",
            "sensor": "false",
            "SO":"\(SO)",
            "Sys":"fptshop"]
        //        let parameters = ["UserID":"\(Helper.getUserName()!)",
        //            "ShopCode":"\(Helper.getShopCode()!)",
        //            "DeviceType": "2",
        //            "origin":"\(mLatUser),\(mLongUser)",
        //            "destination":"\(mLat),\(mLong)",
        //            "key":"AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU",
        //            "mode":"driving",
        //            "sensor": "false",
        //            "SO":"\(SO)",
        //            "Sys":"fptshop"]
        let log = SwiftyBeaver.self
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil,nil,nil,nil,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    let jsonRoute =  json["routes"]
                    let jsonRouteObject = jsonRoute[0];
                    let jsonPolyline = jsonRouteObject["overview_polyline"]
                    let jsonPolylineObject = jsonPolyline["points"]
                    
                    
                    let jsonEnd_address = jsonRouteObject["legs"][0]["end_location"]
                    let mLat = jsonEnd_address["lat"]
                    let mLong = jsonEnd_address["lng"]
                    
                    let jsonDistance = jsonRouteObject["legs"][0]["distance"]["text"]
                    let jsonDuration = jsonRouteObject["legs"][0]["duration"]["value"]
                    
                    print("GetDataGoogleAPITimePoint \(jsonPolylineObject) \(jsonDistance) \(jsonDuration)")
                    completion(nil,true,"\(jsonPolylineObject)","\(mLat)","\(mLong)","\(jsonDistance)","\(jsonDuration)")
//                }
                
            }
        }
        
    }
    
    /////
    
    
    class func GetDatamDel_UpAnh_GHTNResult(SoSO: String,FileName: String,Base64String: String,UserID: String,KH_Latitude: String,KH_Longitude: String,Type: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: mDel_UpAnh_GHTNResult?)->Void)
    {
        _ = [mDel_UpAnh_GHTNResult]();
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getmDel_UpAnh_GHTNResult_Gateway ;
        let log = SwiftyBeaver.self
        let parameters = ["SoSO" : SoSO,"FileName" : FileName,"Base64String" : Base64String,"UserID" : UserID,"KH_Latitude" : KH_Latitude,"KH_Longitude" : KH_Longitude,"Type" : Type]
        log.debug(url)
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
              
                log.debug(json)
                if(json.description != "null")
                {
                    let getSelectFromObject = mDel_UpAnh_GHTNResult.init(mDel_UpAnh_GHTNResult: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    class func GetSetSOPaid(docNum: String, userCode:String, password:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = URLs.getSetSOPaid_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&password=\(password)"  ;
        
        
        log.debug(url)
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
               
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    
    class func GetDataSetSOInfo(docNum :String, userName :String, empName :String , bookDate :String, whConfirmed :String, whDate :String, rejectReason :String, rejectDate :String, paymentType :String, paymentAmount :String, paymentDistance :String , finishLatitude :String, finishLongitude :String, finishTime :String, paidConfirmed :String, paidDate :String, orderStatus :String, u_addDel :String, u_dateDe :String, u_paidMoney :String, rowVersion :String,Is_PushSMS:String,U_AdrDel_New_Reason:String, U_DateDe_New_Reason:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        _ = [ConfirmThuKhoResult]();
        //let url = URLs.getSetSOInfo ;
        
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = URLs.getSetSOInfo_Gateway + "?docNum=\(docNum)&userName=\(userName)&empName=\(empName)&bookDate=\(bookDate)&whConfirmed=\(whConfirmed)&whDate=\(whDate)&rejectReason=\(rejectReason)&rejectDate=\(rejectDate)&paymentType=\(paymentType)&paymentAmount=\(paymentAmount)&paymentDistance=\(paymentDistance)&finishLatitude=\(finishLatitude)&finishLongitude=\(finishLongitude)&finishTime=\(finishTime)&paidConfirmed=\(paidConfirmed)&paidDate=\(paidDate)&orderStatus=\(orderStatus)&u_addDel=\(u_addDel)&u_dateDe=\(u_dateDe)&u_paidMoney=\(u_paidMoney)&rowVersion=\(rowVersion)&Is_PushSMS=\(Is_PushSMS)&U_AdrDel_New_Reason=\(U_AdrDel_New_Reason)&U_DateDe_New_Reason=\(U_DateDe_New_Reason)"  ;
        
        
        log.debug(url)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<600).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
               
                log.debug(json)
                if(json.description != "null")
                {
                    let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    class func GetSODetails(docNum: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: [getSODetailsResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = URLs.getSODetails_Gateway + "?docNum=\(docNum)"  ;
        log.debug(url)
       
        var list:[getSODetailsResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
               
                
                
                for i in 0..<json.count
                {
                    let jsonObject = json[i];
                    let getSelectFromObject = getSODetailsResult.init(getSODetailsResult: jsonObject)
                    list.append(getSelectFromObject)
                }
                completion(nil,true,list)
            }
        }
    }
    ///////////////
    
    class func GetSetSODelivered(docNum: String, userCode:String, latitude:String, longitude:String,paymentType:String,paymentAmount:String , paymentDistance:String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = URLs.getSetSODelivered_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&latitude=\(latitude)&longitude=\(longitude)&paymentType=\(paymentType)&paymentAmount=\(paymentAmount)&paymentDistance=\(paymentDistance)"  ;
        
      
        log.debug(url)
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
            
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    class func GetDataSetSORejected(docNum: String, userCode:String, reason:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let log = SwiftyBeaver.self
        let url = URLs.getSetSORejected_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&reason=\(reason)"  ;
        log.debug(url)
       
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
             
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    ////////////////////////////
    class func GetDataSetSOReturned(docNum: String, userCode:String, reason:String,is_Returned:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getSetSOReturned_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&is_Returned=\(is_Returned)&reason=\(reason)"  ;
        let log = SwiftyBeaver.self
        log.debug(url)
        
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
               
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    class func GetUnConfirmThuKho(docNum: String, userCode:String, password:String,cantCallReason:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getUnConfirmThuKho_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&password=\(password)&cantCallReason=\(cantCallReason)"  ;
        let log = SwiftyBeaver.self
        log.debug(url)
     
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
              
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    class func GetSetSOBooked(docNum: String, userCode:String,empName:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ConfirmThuKhoResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getSetSOBooked_Gateway + "?docNum=\(docNum)&userCode=\(userCode)&empName=\(empName)&updateBy=\(Cache.user!.UserName)"
        let log = SwiftyBeaver.self
        log.debug(url)
        
        var _:[ConfirmThuKhoResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
              
                let getSelectFromObject = ConfirmThuKhoResult.init(ConfirmThuKhoResult: json)
                
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    class func GetDatamDel_UpAnh_GHTG_Result(SoSO: String,FileName: String,Base64String: String,UserID: String,TypeTraGop: String,TypeImg: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: UpAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.GetmDelUpAnhGHTG_Gateway ;
        let parameters = ["SoSO" : SoSO,"FileName" : FileName,"Base64String" : Base64String,"UserID" : UserID,"TypeTraGop" : TypeTraGop,"TypeImg" : TypeImg]
       
        let log = SwiftyBeaver.self
        log.debug(url)
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
             
                if(json.description != "null")
                {
                    let getSelectFromObject = UpAnh_GHTG_Result.init(UpAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    class func GetDatamDel_SaveAnh_GHTG_Result(SoSO: String,UserID: String,ImgUrl_TTD: String,ImgUrl_CMNDMT: String,ImgUrl_HDTC1: String,ImgUrl_HDTC2: String,ImgUrl_HDTC3: String,TypeTraGop: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: SaveAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [SaveAnh_GHTG_Result]();
        let url = URLs.GetmDelSaveAnhGHTG_Gateway ;
        let parameters = ["SoSO": SoSO,"UserID": UserID,"ImgUrl_TTD": ImgUrl_TTD,"ImgUrl_CMNDMT": ImgUrl_CMNDMT,"ImgUrl_HDTC1": ImgUrl_HDTC1,"ImgUrl_HDTC2": ImgUrl_HDTC2,"ImgUrl_HDTC3": ImgUrl_HDTC3,"TypeTraGop": TypeTraGop]
    
        let log = SwiftyBeaver.self
        log.debug(url)
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
             
                if(json.description != "null")
                {
                    let getSelectFromObject = SaveAnh_GHTG_Result.init(SaveAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    ///////////////////
    class func GetDatamDel_SaveAnh_BBGN_Result(SoSO: String,UserID: String,ImgUrl_TTD: String,ImgUrl_CMNDMT: String,ImgUrl_HDTC1: String,ImgUrl_HDTC2: String,ImgUrl_HDTC3: String,TypeTraGop: String,ImgUrl_BBGN:String , completion: @escaping(_ error: Error?, _ success: Bool, _ result: SaveAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [SaveAnh_GHTG_Result]();
        let url = URLs.GetmDelSaveAnhMC_Gateway ;
        let parameters = ["SoSO": SoSO,"UserID": UserID,"ImgUrl_TTD": ImgUrl_TTD,"ImgUrl_CMNDMT": ImgUrl_CMNDMT,"ImgUrl_HDTC1": ImgUrl_HDTC1,"ImgUrl_HDTC2": ImgUrl_HDTC2,"ImgUrl_HDTC3": ImgUrl_HDTC3,"ImgUrl_BBGN": ImgUrl_BBGN,"TypeTraGop": TypeTraGop]
    
        let log = SwiftyBeaver.self
        log.debug(url)
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                
                log.debug(json)
                if(json.description != "null")
                {
                    let getSelectFromObject = SaveAnh_GHTG_Result.init(SaveAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    ////////tab thong ke
    
    class func GetReportDeliveryHeader(p_MaNV: String, p_TinhTrangSO:String,p_SoDHPOS:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ReportDeliveryHeaderGeneralResult?, _ result2: [ReportDeliveryHeaderOrderListResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let formattedString = p_TinhTrangSO.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URLs.getMposd_sp_ReportDeliveryHeader_Gateway + "?p_MaNV=\(p_MaNV)&p_TinhTrangSO=\(formattedString!)&p_SoDHPOS=\(p_SoDHPOS)"  ;
        
        print("url GetReportDeliveryHeader \(url)")
        var list:[ReportDeliveryHeaderOrderListResult] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetReportDeliveryHeader \(json)")
                let jsonHeaderGeneral =  json["mposd_sp_ReportDeliveryHeaderGeneralResult"]
                let jsonHeaderOrder =  json["mposd_sp_ReportDeliveryHeaderOrderListResult"]
                
                let getSelectFromObject = ReportDeliveryHeaderGeneralResult.init(ReportDeliveryHeaderGeneralResult: jsonHeaderGeneral)
                for i in 0..<jsonHeaderOrder.count
                {
                    let jsonObject = jsonHeaderOrder[i];
                    let getSelectFromObject2 = ReportDeliveryHeaderOrderListResult.init(ReportDeliveryHeaderOrderListResult: jsonObject)
                    list.append(getSelectFromObject2)
                }
                completion(nil,true,getSelectFromObject,list)
            }
        }
    }
    
    
    ///ios = 1
    class func GetDeviceToken(deviceId: String, deviceType:String,userCode:String,token:String, completion: @escaping(_ error: Error?, _ success: Bool)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getNotification_Gateway + "?deviceId=\(deviceId)&deviceType=\(deviceType)&userCode=\(userCode)&token=\(token)"  ;
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false)
            case .success(let value):
                let json = JSON(value)
                print("GetDeviceToken \(json)")
                completion(nil,true)
            }
        }
    }
    
    
    class func Get_ReportDeliveryDetail(p_SoDonHangPOS: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: ReportDeliveryDetailResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.getReportDeliveryDetail_Gateway + "?p_SoDonHangPOS=\(p_SoDonHangPOS)"  ;
        
        print("url \(url)")
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("ReportDeliveryDetailResult \(json)")
                let getSelectFromObject = ReportDeliveryDetailResult.init(ReportDeliveryDetailResult: json)
                completion(nil,true,getSelectFromObject)
            }
        }
    }
    
    
    
    class func GetDatamDel_UpAnh_MC_Result(SoSO: String,FileName: String,Base64String: String,TypeImg: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: UpAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.GetmDelUpAnhMC_Gateway ;
        let log = SwiftyBeaver.self
        log.debug(url)
        let parameters = ["SoSO" : SoSO,"FileName" : FileName,"Base64String" : Base64String,"TypeImg" : TypeImg]
        //print("GetmDelUpAnhMC \(parameters)")
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
            
                if(json.description != "null")
                {
                    let getSelectFromObject = UpAnh_GHTG_Result.init(UpAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    
    class func GetDatamDel_SaveAnh_MC_Result(SoSO: String,UserID: String,ImgUrl_Receiver: String,ImgUrl_Touch: String,ImgUrl_Red: String,ImgUrl_MSM: String,ImgUrl_MTM: String,ImgUrl_Imei: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: SaveAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [SaveAnh_GHTG_Result]();
        let url = URLs.GetmDelSaveAnhMC_Gateway ;
        let log = SwiftyBeaver.self
        log.debug(url)
        let parameters = ["SoSO": SoSO,"UserID": UserID,"ImgUrl_Receiver": ImgUrl_Receiver,"ImgUrl_Touch": ImgUrl_Touch,"ImgUrl_Red": ImgUrl_Red,"ImgUrl_MSM": ImgUrl_MSM,"ImgUrl_MTM": ImgUrl_MTM,"ImgUrl_Imei": ImgUrl_Imei]
        //print("GetDatamDel_SaveAnh_MC_Result \(parameters)")
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                log.debug(json)
                //print("GetDatamDel_SaveAnh_MC_Result \(json)")
                if(json.description != "null")
                {
                    let getSelectFromObject = SaveAnh_GHTG_Result.init(SaveAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    ///// bao hanh
    class func GetLocationByUser(p_User: String,p_Loai: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [AllNhanVienPhanCong_MobileResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [AllNhanVienPhanCong_MobileResult]();
          let log = SwiftyBeaver.self
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOCATIONBYUSER_Gateway)" + "?p_User=\(p_User)&p_Loai=\(p_Loai)"
        //print("url \(url)")
        log.debug(url)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    log.debug(json)
                    //print("AllNhanVienPhanCong_MobileResult \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = AllNhanVienPhanCong_MobileResult.init(AllNhanVienPhanCong_MobileResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    //**** GetLoadChiTietPhieuNhan ****//
    class func GetLoadChiTietPhieuNhan(p_MaNoiGN: String,p_UserPhanCong: String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieuNhan]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieuNhan]();
        let log = SwiftyBeaver.self
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOADCHITIETPHIEUNHAN_Gateway)" + "?p_MaNoiGN=\(p_MaNoiGN)&p_UserPhanCong=\(p_UserPhanCong)"
        //print("url \(url)")
        log.debug(url)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                log.error(error)
                //print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    log.debug(json)
                    //print("GiaoNhan_LoadChiTietPhieuNhan \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieuNhan.init(GiaoNhan_LoadChiTietPhieuNhan: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    //**** GetLoadChiTietPhieuGiao ****//
    class func GetLoadChiTietPhieuGiao(p_MaNoiGN: String,p_UserPhanCong: String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieuGiao]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieuGiao]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOADCHITIETPHIEUGIAO_Gateway)" + "?p_MaNoiGN=\(p_MaNoiGN)&p_UserPhanCong=\(p_UserPhanCong)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    print("GiaoNhan_LoadChiTietPhieuGiao \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieuGiao.init(GiaoNhan_LoadChiTietPhieuGiao: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    /////
    class func GetDataGoogleAPITime(mLatUser:String , mLongUser:String ,mLat: String,mLong: String,SO:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        
        
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(mLatUser),\(mLongUser)&destination=\(mLat),\(mLong)&key=AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU&mode=driving&sensor=false"
//        print("GetDataGoogleAPITimeResult \(url)")
        //
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = "\(Config.manager.URL_GATEWAY!)/mpos-cloud-mdelpharbeta/api/Place/mdel_googleapi_directions"
        print("GetDataGoogleAPITime \(url)")
        let parameters = ["UserID":"\(Helper.getUserName()!)",
            "ShopCode":"\(Helper.getShopCode()!)",
        "DeviceType": "2",
        "origin":"\(mLatUser),\(mLongUser)",
            "destination":"\(mLat)",
            "key":"AIzaSyAyFWaYtFi18p1LZrYKm63cIpFbDXl84TU",
            "mode":"driving",
            "sensor": "false",
            "SO":"\(SO)",
            "Sys":"fptshop"]
        print(parameters)
        //
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    let jsonRoute =  json["routes"]
                    let jsonRouteObject = jsonRoute[0];
                    let jsonLeg = jsonRouteObject["legs"]
                    let jsonLegObject = jsonLeg[0]["distance"]
                    
                    print("GetDataGoogleAPITimeResult \(jsonLegObject) \(mLat) \(mLong)")
                    completion(nil,true,"\(jsonLegObject["value"])")

                
                
            }
        }
        
    }
    
    
    
    
    
    
    //**** GetSoPhieuGiaoNhan ****//
    class func GetSoPhieuGiaoNhan(p_MaNoiGN: String,p_UserPhanCong:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadSoPhieuGiaoNhan]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadSoPhieuGiaoNhan]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETSOPHIEUGIAONHAN_Gateway)" + "?p_MaNoiGN=\(p_MaNoiGN)&p_UserPhanCong=\(p_UserPhanCong)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetSoPhieuGiaoNhan \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadSoPhieuGiaoNhan.init(GiaoNhan_LoadSoPhieuGiaoNhan: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    
    //**** GetSoPhieuGiaoNhan ****//
    class func GetLichSuGiaoNhan(p_MaNhanVien: String,p_NgayChon: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LichSuGiaoNhan]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LichSuGiaoNhan]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLICHSUGIAONHAN_Gateway)" + "?p_MaNhanVien=\(p_MaNhanVien)&p_NgayChon=\(p_NgayChon)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetSoPhieuGiaoNhan \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LichSuGiaoNhan.init(GiaoNhan_LichSuGiaoNhan: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    //**** GIAONHAN_GETDSLOTRINH ****//
    class func GetDsLoTrinh(p_MaNhanVien: String,p_NgayChon: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_DanhSachLoTrinh]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_DanhSachLoTrinh]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETDSLOTRINH_Gateway)" + "?p_MaNhanVien=\(p_MaNhanVien)&p_NgayChon=\(p_NgayChon)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetSoPhieuGiaoNhan \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_DanhSachLoTrinh.init(GiaoNhan_DanhSachLoTrinh: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    
    /////
    class func GiaoNhan_CallUpHinh(p_FileName: String,p_UserCode:String,p_UserName:String,p_Base64:String,ListGiaoNhan:String ,TypeImg:String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_UploadHinh]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_UploadHinh]();
        let parameters = ["p_FileName" : p_FileName ,"p_UserCode": p_UserCode , "p_UserName" : p_UserName, "p_Base64" : p_Base64, "ListGiaoNhan" : ListGiaoNhan , "TypeImg" : TypeImg ]
     
        let url = "\(URLs.GIAONHAN_UPHINH_Gateway)"
    
        let log = SwiftyBeaver.self
        log.debug(url)
        log.debug(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    //let results = json as! NSDictionary
                    
                    let json = JSON(value)
                    log.debug(json)
                   
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_UploadHinh.init(GiaoNhan_UploadHinh: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
                    
//                }
//                else
//                {
//                    completion(nil,true,nil)
//                }
                
            }
        }
        
    }
    ////
    //**** GIAONHAN_CHECKIN ****//
    class func GiaoNhan_CallCheckin(p_DiemDen:String ,p_DiemBatDau:String ,p_DoDai:String,p_Note:String,p_ListGiao:String,p_ListNhan:String,p_SLGiao:String,p_SLNhan:String,p_Latitude:String,p_Longitude:String,p_UserCode:String,p_Action:String,p_TypeDevice:String,p_LinkHinhAnhXacNhan:String,p_LinkChuKy:String,p_Type:String, p_LinkHinhAnhChuKyGiaoNhan :String ,p_UserCode_XN:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_CheckInResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_CheckInResult]();
        let parameters = ["p_DiemDen" : p_DiemDen,"p_DiemBatDau" : p_DiemBatDau,"p_DoDai" : p_DoDai,"p_Note" : p_Note,"p_ListGiao" : p_ListGiao, "p_ListNhan": p_ListNhan, "p_SLGiao": p_SLGiao , "p_SLNhan": p_SLNhan, "p_Latitude": p_Latitude , "p_Longitude": p_Longitude , "p_UserCode": p_UserCode , "p_Action": p_Action , "p_TypeDevice": p_TypeDevice, "p_LinkHinhAnhXacNhan": p_LinkHinhAnhXacNhan , "p_LinkChuKy": p_LinkChuKy,"p_Type":p_Type,"p_UserCode_XN":p_UserCode_XN,"p_LinkHinhAnhChuKyGiaoNhan":p_LinkHinhAnhChuKyGiaoNhan]
        print("asasad \(parameters)")
        let url = "\(URLs.GIAONHAN_CHECKIN_Gateway)"
        print("url \(url)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GiaoNhan_CallCheckin \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_CheckInResult.init(GiaoNhan_CheckInResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
//                else
//                {
//                    completion(nil,true,nil)
//                }
                
                
            }
        }
        
    }
    
    //**** GetLoadChiTietPhieuNhan Hang ****//
    class func GetLoadChiTietPhieuNhan_Hang(p_MaHang: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieu_HangResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieu_HangResult]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_Gateway)" + "?p_MaHang=\(p_MaHang)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    print("GetLoadChiTietPhieuNhan_Hang \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieu_HangResult.init(GiaoNhan_LoadChiTietPhieu_HangResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    //**** GetLoadChiTietPhieuOnClick ****//
    class func GetLoadChiTietPhieuOnClick(p_MaBBBG: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieu_HangResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieu_HangResult]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_LOADCHITIETPHIEU_Gateway)" + "?p_MaBBBG=\(p_MaBBBG)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetLoadChiTietPhieuOnClick \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieu_HangResult.init(GiaoNhan_LoadChiTietPhieu_HangResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                    }
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
            }
        }
        
    }
    
    
    
    
    //**** GetLoadChiTietPhieuNhan Hang ****//
    class func GetLoadChiTietPhieuNhan_HangLichSu(p_MaCheckIn: String,p_Type:String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieu_HangResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieu_HangResult]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_LICHSU_Gateway)" + "?p_MaCheckIn=\(p_MaCheckIn)&p_Type=\(p_Type)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    print("GetLoadChiTietPhieuNhan_HangLichSu \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieu_HangResult.init(GiaoNhan_LoadChiTietPhieu_HangResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    //**** GetLoadChiTietPhieuNhan Hang ****//
    class func GetLoadChiTietPhieuNhan_HangLichSu_Not_Hang(p_MaCheckIn: String,p_Type:String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GiaoNhan_LoadChiTietPhieuGiao]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [GiaoNhan_LoadChiTietPhieuGiao]();
        //let parameters = ["usercode" : usercode,"shopcode" : shopcode,"transType" : transType]
        let url = "\(URLs.GIAONHAN_GETLOADCHITIETPHIEUNHAN_HANG_LICHSU_NOT_HANG_Gateway)" + "?p_MaCheckIn=\(p_MaCheckIn)&p_Type=\(p_Type)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    
                    
                    let json = JSON(value)
                    print("GetLoadChiTietPhieuNhan_HangLichSu_Not_Hang \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = GiaoNhan_LoadChiTietPhieuGiao.init(GiaoNhan_LoadChiTietPhieuGiao: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    
    
    
    class func GetDatamDel_UpAnh_FF_Result(SoSO: String,FileName: String,Base64String: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: UpAnh_GHTG_Result?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.FFRIENDS_UPHINH_Gateway ;
        let parameters = ["SoSO" : SoSO,"FileName" : FileName,"Base64String" : Base64String]
        print("GetDatamDel_UpAnh_FF_Result \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetDatamDel_UpAnh_FF_Result \(json)")
                if(json.description != "null")
                {
                    let getSelectFromObject = UpAnh_GHTG_Result.init(UpAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    
    class func GetDatamDel_SaveAnh_FF_Result(p_ID: String,p_DiviceType: String,p_Url_PDK_MatTruocCMND: String,p_UpdateBy:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: SaveAnh_GHTG_Result?)->Void)
    {
        _ = [UpAnh_GHTG_Result]();
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = "\(URLs.FFRIENDS_SAVEHINH_Gateway)" + "?p_ID=\(p_ID)&p_DiviceType=\(p_DiviceType)&p_Url_PDK_MatTruocCMND=\(p_Url_PDK_MatTruocCMND)&p_UpdateBy=\(p_UpdateBy)"
        //print("GetDatamDel_SaveAnh_FF_Result \(parameters)")
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetDatamDel_SaveAnh_FF_Result \(json)")
                if(json.description != "null")
                {
                    let getSelectFromObject = SaveAnh_GHTG_Result.init(SaveAnh_GHTG_Result: json)
                    completion(nil,true,getSelectFromObject)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    //**** GetLoad List Notification ****//
    class func GetLoadListNotification(p_UserCode: String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [mDel_ReportNotificationResult]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [mDel_ReportNotificationResult]();
        let url = "\(URLs.GIAONHAN_REPORTNOTIFICATION_Gateway)" + "?p_UserCode=\(p_UserCode)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetLoadChiTietPhieuNhan_HangLichSu \(json)")
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = mDel_ReportNotificationResult.init(mDel_ReportNotificationResult: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    
    
    //**** GetLoad List Notification ****//
    class func GetUpdateNotification(p_ID_Notification: String ,p_AppStatus: String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: [UpAnh_GHTG_Result]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArrayBody = [UpAnh_GHTG_Result]();
        let url = "\(URLs.getmDel_UpdateNotification_Gateway)" + "?p_ID_Notification=\(p_ID_Notification)&&p_AppStatus=\(p_AppStatus)"
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GetUpdateNotification \(json)")
                    
                    for i in 0..<json.count
                    {
                        let jsonObject = json[i];
                        let getSelectFromObject = UpAnh_GHTG_Result.init(UpAnh_GHTG_Result: jsonObject)
                        getSelectFromResultArrayBody.append(getSelectFromObject)
                        
                    }
                    
                    
                    
                    
                    completion(nil,true,getSelectFromResultArrayBody)
//                }
                
                
            }
        }
        
    }
    
    
    
    
    class func GetDataMPloyeeByShop_KYTHUAT(shopCode: String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: [GetTechnicalEmpShopKyThuat]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        var getSelectFromResultArray = [GetTechnicalEmpShopKyThuat]();
        let url = "\(URLs.KYTHUAT_GETEMPLOY_BYSHOP_Gateway)" + "?shopCode=\(shopCode)"
        print("url \(url)")
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetTechnicalEmpShopKyThuat \(json) - \(json["code"])")
                if(json["code"].intValue == 1)
                {
                    for i in 0..<json["data"].count
                    {
                        let jsonObject = json["data"][i];
                        let getSelectFromObject = GetTechnicalEmpShopKyThuat.init(GetTechnicalEmpShopKyThuat: jsonObject)
                        getSelectFromResultArray.append(getSelectFromObject)
                        
                    }
                    completion(nil,true,getSelectFromResultArray)
                }
                else
                {
                    completion(nil,false,nil)
                }
            }
        }
        
    }
    
    
    class func GetDataCreateDH_KyThuat(mCreateType: String,mAddress: String,mTime: String,mDocnum: String,mUserBook:String ,mAssigner:String ,mContentWork:String ,mCustomerName:String, mCustomerAddress:String , mCustomerPhoneNum:String , mInstallLocation:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.KYTHUAT_CREATE_DH_Gateway ;
        let parameters = ["mCreateType" : mCreateType,"mAddress" : mAddress,"mTime" : mTime,
                          "mDocnum" : mDocnum,"mUserBook" : mUserBook,"mAssigner" : mAssigner,
                          "mContentWork" : mContentWork,"mCustomerName" : mCustomerName,"mCustomerAddress" : mCustomerAddress,
                          "mCustomerPhoneNum" : mCustomerPhoneNum,"mInstallLocation" : mInstallLocation]
        print("GetDataCreateDH_KyThuat \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetDataCreateDH_KyThuat \(json)")
                if(json["code"].intValue == 1)
                {
                    completion(nil,true,nil)
                }
                else
                {
                    completion(nil,false,nil)
                }
                
            }
        }
        
    }
    
    
    
    class func GetDataUpDateDH_KyThuat(mCreateType: String,mDocEntry: String,mApproveStatus: String,mReason: String,mUserAppr:String ,mLatitude:String,mLongtitude:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.KYTHUAT_UPDATE_ORDER_STS_Gateway ;
        let parameters = ["mCreateType" : mCreateType,"mDocEntry" : mDocEntry,"mApproveStatus" : mApproveStatus,
                          "mReason" : mReason,"mUserAppr" : mUserAppr,"mLatitude" : mLatitude ,"mLongtitude" : mLongtitude]
        print("GetDataCreateDH_KyThuat \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetDataCreateDH_KyThuat \(json)")
                if(json["code"].intValue == 1)
                {
                    completion(nil,true,"1")
                }
                else
                {
                    let mString:String = json["message"].stringValue
                    completion(nil,false,mString)
                }
                
            }
        }
        
    }
    
    
    
    
    class func GetDataYeuCauDuyet_KyThuat(mUserNoti: String,mMessageNoti: String , completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.KYTHUAT_REQUEST_SMCHECK_Gateway ;
        let parameters = ["mUserNoti" : mUserNoti,"mMessageNoti" : mMessageNoti]
        print("GetDataYeuCauDuyet_KyThuat \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("GetDataYeuCauDuyet_KyThuat \(json)")
                if(json["code"].intValue == 1)
                {
                    completion(nil,true,nil)
                }
                else
                {
                    completion(nil,false,nil)
                }
                
            }
        }
        
    }
    
    
    
    
    
    //////  LCNB    ////////
    
    class func LCNB_GetData_DSPHIEU(p_TypeTran: String,p_MaShop:String,p_UserID:String,p_Status:String, completion: @escaping(_ error: Error?, _ success: Bool, _ result: [LCNB_GetDSPhieu]?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.LCNB_GETDS_PHIEU_Gateway + "?p_TypeTran=\(p_TypeTran)&p_MaShop=\(p_MaShop)&p_UserID=\(p_UserID)&p_Status=\(p_Status)"  ;
        
        print("url \(url)")
        var list:[LCNB_GetDSPhieu] = []
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("LCNB_GetData_DSPHIEU \(json)")
                if(json["code"].intValue == 1)
                {
                    for i in 0..<json["data"].count
                    {
                        let jsonObject = json["data"][i];
                        let getSelectFromObject = LCNB_GetDSPhieu.init(LCNB_GetDSPhieu: jsonObject)
                        list.append(getSelectFromObject)
                    }
                    
                    completion(nil,true,list)
                }
                else
                {
                    completion(nil,false,nil)
                }
                
            }
        }
    }
    
    
    class func LCNB_GetData_XacNhanGiaoNhan(p_MaShop: String,p_UserID: String,p_FinishLatitude: String,p_FinishLongitude: String,p_ListRefNum: String,p_Usercomfirm: String,p_Pass_UserConfirm: String , completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [UpAnh_GHTG_Result]();
        let url = URLs.LCNB_XACNHAN_GIAONHAN_Gateway ;
        let parameters = ["p_MaShop" : p_MaShop,"p_UserID" : p_UserID,"p_FinishLatitude" : p_FinishLatitude,"p_FinishLongitude" : p_FinishLongitude,"p_ListRefNum" : p_ListRefNum,"p_Usercomfirm" : p_Usercomfirm,"p_Pass_UserConfirm" : p_Pass_UserConfirm]
        print("LCNB_GetData_XacNhanGiaoNhan \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
                let json = JSON(value)
                print("LCNB_GetData_XacNhanGiaoNhan \(json)")
                if(json["code"].intValue == 1)
                {
                    completion(nil,true,nil)
                }
                else
                {
                    completion(nil,false,json["message"].stringValue)
                }
                
            }
        }
        
    }
    
    
    ///////GIAO NHAN - UPLOAD CHU KI
    
    class func GiaoNhan_CallUpHinhChuKi(Docentry: String,DiviceType:String,CustomerSignature:String,Deliverer:String,Stockkeeper:String ,Accountant:String,KH_Latitude:String,KH_Longitude:String,khoangcach:String ,completion: @escaping(_ error: Error?, _ success: Bool, _ result: GenImage_Confirm_DeliverResult?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        _ = [GenImage_Confirm_DeliverResult]();
        let parameters = ["Docentry" : Docentry ,"DiviceType": DiviceType , "CustomerSignature" : CustomerSignature, "Deliverer" : Deliverer, "Stockkeeper" : Stockkeeper , "Accountant" : Accountant,"KH_Latitude":"\(KH_Latitude)","KH_Longitude":"\(KH_Longitude)","khoangcach":"\(khoangcach)" ]
        print("parameters \(parameters)")
        let url = "\(URLs.GIAONHAN_UPLOAD_CHUKI_GATEWAY)"
        print("url \(url)")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    //let results = json as! NSDictionary
                    let json = JSON(value)
                    print("GIAONHAN_UPLOAD_CHUKI \(json)")
                    let getSelectFromObject = GenImage_Confirm_DeliverResult.init(GenImage_Confirm_DeliverResult: json)
                    
                    
                    completion(nil,true,getSelectFromObject)
                    
//                }
//                else
//                {
//                    completion(nil,true,nil)
//                }
                
            }
        }
        
    }
    
    /////
    
    class func GiaoNhan_CheckUserShop(p_UserCode: String,p_ShopCode:String,completion: @escaping(_ error: Error?, _ success: Bool, _ result: String?)->Void)
    {
        var access_token = MDeliveryAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        let headers_Gateway: HTTPHeaders = [
            "Content-type": "application/json",
            "Authorization": "Bearer \(access_token!)"
        ]
        let url = URLs.GIAONHAN_CHECKUSERSHOP_Gateway + "?p_UserCode=\(p_UserCode)&p_ShopCode=\(p_ShopCode)"  ;
        print("url \(url)")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding(options: []),headers: headers_Gateway).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
            case .success(let value):
//                if response.result.value != nil {
                    let json = JSON(value)
                    print("GiaoNhan_CheckUserShop \(json)")
                    if(json["code"].intValue == 1)
                    {
                        completion(nil,true,json["message"].stringValue)
                    }
                    else
                    {
                        completion(nil,false,json["message"].stringValue)
                    }
                    
//                }
//                else
//                {
//                    completion(nil,true,nil)
//                }
                
            }
        }
        
    }
}





